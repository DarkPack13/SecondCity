/// Attacks the target mob; SUCCEEDED when target is gone, FAILED when target goes down (Which lets us flush the fucker instead)
/datum/bt_node/ai_behavior/human_attack_mob
	var/target_key
	/// seconds_per_tick from the perform() that kicked off the current async attack.
	VAR_PRIVATE/attack_seconds_per_tick = 0
	/// Weapon snapshot from the perform() that kicked off the current async attack.
	VAR_PRIVATE/obj/item/attack_holding_weapon

/datum/bt_node/ai_behavior/human_attack_mob/perform(seconds_per_tick, datum/ai_controller/controller)
	var/async_flags = handle_async()
	if(async_flags)
		return async_flags

	var/mob/living/target = controller.blackboard[target_key]
	var/mob/living/living_pawn = controller.pawn
	var/datum/targeting_strategy/strategy = GET_TARGETING_STRATEGY(controller.blackboard[BB_TARGETING_STRATEGY])

	if(QDELETED(target) || !strategy.is_valid_target(living_pawn, target))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/obj/item/holding_weapon
	for(var/obj/item/potential_weapon as anything in target.get_held_items())
		if(!(potential_weapon.item_flags & ABSTRACT))
			holding_weapon = potential_weapon
			break

	attack_seconds_per_tick = seconds_per_tick
	attack_holding_weapon = holding_weapon
	return start_async()

/datum/bt_node/ai_behavior/human_attack_mob/perform_async(datum/ai_controller/controller)
	var/mob/living/target = controller.blackboard[target_key]
	var/seconds_per_tick = attack_seconds_per_tick
	var/obj/item/holding_weapon = attack_holding_weapon
	var/attack_results = human_attack(controller, target, seconds_per_tick, holding_weapon && SPT_PROB(MONKEY_ATTACK_DISARM_PROB, seconds_per_tick), holding_weapon)
	if(!async_still_valid())
		return
	finish_async(attack_results ? AI_BEHAVIOR_SUCCEEDED : AI_BEHAVIOR_FAILED)

/datum/bt_node/ai_behavior/human_attack_mob/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	attack_seconds_per_tick = 0
	attack_holding_weapon = null

/// Attack with held weapon or bite; try to disarm if target is holding something
/datum/bt_node/ai_behavior/human_attack_mob/proc/human_attack(datum/ai_controller/controller, mob/living/target, seconds_per_tick, disarm, holding_weapon)
	var/mob/living/living_pawn = controller.pawn

	if(living_pawn.next_move > world.time)
		return FALSE

	living_pawn.face_atom(target)

	var/obj/item/potential_weapon = living_pawn.is_holding_item_of_type(/obj/item)

	if(potential_weapon)
		var/datum/component/two_handed/twohanded = potential_weapon.GetComponent(/datum/component/two_handed)
		if(twohanded)
			twohanded.wield(living_pawn)
		var/datum/component/transforming/transforming = potential_weapon.GetComponent(/datum/component/transforming)
		if(transforming)
			transforming.set_active(potential_weapon)

	if(target.IsReachableBy(living_pawn, potential_weapon?.reach))
		if(isnull(potential_weapon))
			controller.ai_interact(target = target, modifiers = disarm ? list(RIGHT_CLICK = TRUE) : null, combat_mode = TRUE)
			if(disarm && !isnull(holding_weapon) && controller.blackboard[BB_MONKEY_BLACKLISTITEMS][holding_weapon])
				controller.remove_thing_from_blackboard_key(BB_MONKEY_BLACKLISTITEMS, holding_weapon)
		else
			if(potential_weapon != living_pawn.get_active_held_item())
				living_pawn.swap_hand(living_pawn.get_inactive_hand_index())
			controller.ai_interact(target = target, combat_mode = TRUE)
		return TRUE

	if(!potential_weapon)
		return FALSE

	// target out of melee reach — try ranged or throw
	var/atom/real_target = target
	if(prob(10)) // artificial miss
		real_target = pick(oview(2, target))

	var/obj/item/gun/gun = living_pawn.is_holding_item_of_type(/obj/item/gun)
	var/can_shoot = gun?.can_shoot() || FALSE
	if(gun || (!can_shoot && prob(95)))
		if(gun != living_pawn.get_active_held_item())
			living_pawn.swap_hand(living_pawn.get_inactive_hand_index())
		controller.ai_interact(target = real_target, combat_mode = TRUE)
	else
		living_pawn.throw_item(real_target)
	return TRUE
