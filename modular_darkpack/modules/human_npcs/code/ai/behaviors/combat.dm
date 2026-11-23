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


/// Prepare the held item for immeditate combat
/datum/bt_node/ai_behavior/human_ready_weapon

/datum/bt_node/ai_behavior/human_ready_weapon/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn

	if(living_pawn.next_move > world.time)
		return AI_BEHAVIOR_FAILED

	var/obj/item/potential_weapon = living_pawn.is_holding_item_of_type(/obj/item)
	if(!potential_weapon)
		return AI_BEHAVIOR_FAILED

	var/datum/component/two_handed/twohanded = potential_weapon.GetComponent(/datum/component/two_handed)
	if(twohanded && !twohanded.wielded)
		twohanded.wield(living_pawn)
		return AI_BEHAVIOR_SUCCEEDED
	var/datum/component/transforming/transforming = potential_weapon.GetComponent(/datum/component/transforming)
	if(transforming && !transforming.active)
		transforming.set_active(potential_weapon)
		return AI_BEHAVIOR_SUCCEEDED

	if(istype(potential_weapon, /obj/item/gun/ballistic))
		if(handle_gun(potential_weapon, controller))
			return AI_BEHAVIOR_SUCCEEDED
		else
			return AI_BEHAVIOR_FAILED

	return AI_BEHAVIOR_FAILED

#warn could use a refactor
/datum/bt_node/ai_behavior/human_ready_weapon/proc/handle_gun(obj/item/gun/ballistic/weapon, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	if(weapon.can_shoot())
		return FALSE

	if(!weapon?.magazine.ammo_count())
		if(try_reload(weapon, controller))
			return TRUE
	else
		weapon.rack(living_pawn)
		if(!weapon.chambered)
			weapon.chamber_round()

	/*
		weapon.rack(living_pawn)
		if(!weapon.chambered)
			weapon.chamber_round()
	*/

/datum/bt_node/ai_behavior/human_ready_weapon/proc/try_reload(obj/item/gun/ballistic/weapon, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn

	var/list/possible_ammo = list()
	for(var/obj/item/worn_item in living_pawn.get_equipped_items(INCLUDE_POCKETS))
		possible_ammo |= worn_item
		if(istype(worn_item, /obj/item/storage/backpack)) // 100% a better way to do this....
			for(var/obj/item/backpack_content in worn_item.contents)
				possible_ammo |= backpack_content

	var/offhand = living_pawn.get_inactive_held_item()
	if(offhand)
		possible_ammo += offhand

	if(istype(weapon.magazine, /obj/item/ammo_box/magazine/internal))
		var/obj/item/ammo_box/magazine/internal_mag = weapon.magazine
		var/desired_ammo_type = internal_mag.ammo_type
		for(var/obj/item/stuff in possible_ammo)
			if(istype(stuff, desired_ammo_type))
				weapon.load_gun(stuff, living_pawn)
				return TRUE
	else
		var/mag_type = weapon.accepted_magazine_type
		for(var/obj/item/stuff in possible_ammo)
			if(istype(stuff, mag_type))
				if (!weapon.magazine)
					weapon.insert_magazine(living_pawn, stuff)
				weapon.eject_magazine(living_pawn, TRUE, stuff, mag_retention = FALSE)
				return TRUE

/datum/bt_node/ai_behavior/human_ready_weapon/proc/rack_held_gun(obj/item/gun/ballistic/weapon, mob/user)
	if(weapon.bolt_locked)
		weapon.drop_bolt()
	weapon.rack(user)

/*
/obj/item/gun/ballistic/proc/eject_magazine_npc(mob/user, obj/item/ammo_box/magazine/tac_load = null)

	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	if (magazine.ammo_count())
		playsound(src, load_sound, load_sound_volume, load_sound_vary)
	else
		playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
	magazine.forceMove(drop_location())
	var/obj/item/ammo_box/magazine/old_mag = magazine

	if (tac_load)
		tac_load.forceMove(src)
		if (bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			chamber_round(TRUE)
		magazine = tac_load
	else
		magazine = null

	old_mag.forceMove(get_turf(user))
	old_mag.update_icon()
	update_icon()
*/

// Were holding something? DO something with it if we dont need it.
/datum/bt_node/ai_behavior/human_stow_weapon
	var/owned_items_key = BB_HUMAN_OWNED_WEAPONS

/datum/bt_node/ai_behavior/human_stow_weapon/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	for(var/obj/item/held_item in living_pawn.get_held_items())
		if(!(held_item in controller.blackboard[owned_items_key]))
			if(prob(controller.get_npc_attribute(BB_HUMAN_ATTRIBUTE_RESPONSIBILITY)))
				if(living_pawn.dropItemToGround(held_item)) // Not mine, i dont want it.
					return AI_BEHAVIOR_SUCCEEDED
				return AI_BEHAVIOR_FAILED
			else
				controller.add_blackboard_key_lazylist(BB_HUMAN_OWNED_WEAPONS, held_item) // MINE now.

		var/datum/component/transforming/transforming = held_item.GetComponent(/datum/component/transforming)
		if(transforming?.active)
			transforming.set_inactive(held_item)
			return AI_BEHAVIOR_SUCCEEDED

		if(held_item.equip_to_best_slot(living_pawn))
			return AI_BEHAVIOR_SUCCEEDED

	return AI_BEHAVIOR_FAILED
