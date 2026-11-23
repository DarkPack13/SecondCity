// Pickup that can.

/// Base equip behavior; handles blacklist updates and key cleanup on finish
/datum/bt_node/ai_behavior/human_equip
	var/target_key

/datum/bt_node/ai_behavior/human_equip/finish_action(datum/ai_controller/controller, success)
	. = ..()
	if(!success) // Don't try to pick this item up again
		controller.set_blackboard_key_assoc(BB_MONKEY_BLACKLISTITEMS, controller.blackboard[target_key], TRUE)
	controller.clear_blackboard_key(BB_MONKEY_PICKUPTARGET)
	// controller.clear_blackboard_key(BB_MONKEY_PICKUP_IS_PICKPOCKET)

/// Equip a weapon off the ground
/datum/bt_node/ai_behavior/human_equip/ground_or_self

/datum/bt_node/ai_behavior/human_equip/ground_or_self/setup(datum/ai_controller/controller)
	var/obj/item/target = controller.blackboard[target_key]
	return !QDELETED(target)

/datum/bt_node/ai_behavior/human_equip/ground_or_self/perform(seconds_per_tick, datum/ai_controller/controller)
	var/async_flags = handle_async()
	if(async_flags)
		return async_flags

	// Someone may have picked it up while we walked over, don't yank it out of their inventory.
	var/obj/item/target = controller.blackboard[target_key]
	if(QDELETED(target) || !(isturf(target.loc) || (controller.pawn && (controller.pawn in get_nested_locs(target)))))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	return start_async()

/datum/bt_node/ai_behavior/human_equip/ground_or_self/perform_async(datum/ai_controller/controller)
	var/result = equip_item(controller)
	if(!async_still_valid())
		return
	finish_async(result ? AI_BEHAVIOR_SUCCEEDED : AI_BEHAVIOR_FAILED)

/*
/// Pickpocket a weapon from a mob
/datum/bt_node/ai_behavior/human_equip/pickpocket

/datum/bt_node/ai_behavior/human_equip/pickpocket/setup(datum/ai_controller/controller)
	var/obj/item/target = controller.blackboard[target_key]
	return !QDELETED(target)

/datum/bt_node/ai_behavior/human_equip/pickpocket/perform(seconds_per_tick, datum/ai_controller/controller)
	if(controller.blackboard[BB_MONKEY_PICKPOCKETING]) // mid-snatch; wait
		return AI_BEHAVIOR_DELAY
	INVOKE_ASYNC(src, PROC_REF(attempt_pickpocket), controller)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/bt_node/ai_behavior/human_equip/pickpocket/proc/attempt_pickpocket(datum/ai_controller/controller)
	var/obj/item/target = controller.blackboard[BB_MONKEY_PICKUPTARGET]
	var/mob/living/victim = target?.loc
	var/mob/living/living_pawn = controller.pawn

	if(!istype(victim))
		finish_action(controller, FALSE)
		return

	victim.visible_message(span_warning("[living_pawn] starts trying to take [target] from [victim]!"), span_danger("[living_pawn] tries to take [target]!"))
	controller.set_blackboard_key(BB_MONKEY_PICKPOCKETING, TRUE)

	var/success = FALSE

	if(do_after(living_pawn, MONKEY_ITEM_SNATCH_DELAY, victim) && !QDELETED(target) && victim.IsReachableBy(living_pawn) && victim.is_holding(target))
		if(!victim.temporarilyRemoveItemFromInventory(target))
			victim.visible_message(span_danger("[living_pawn] tried to snatch [target] from [victim], but failed!"), span_userdanger("[living_pawn] tried to grab your [target.name]!"))
		else
			victim.visible_message(span_danger("[living_pawn] snatches [target] from [victim]."), span_userdanger("[living_pawn] snatched [target]!"))
			success = TRUE
			if(!equip_item(controller))
				target.forceMove(living_pawn.drop_location())

	finish_action(controller, success)

/datum/bt_node/ai_behavior/human_equip/pickpocket/finish_action(datum/ai_controller/controller, success)
	. = ..()
	controller.set_blackboard_key(BB_MONKEY_PICKPOCKETING, FALSE)
*/

/// Shared item equip proc
/datum/bt_node/ai_behavior/human_equip/proc/equip_item(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/obj/item/target = controller.blackboard[BB_MONKEY_PICKUPTARGET]
	var/best_force = controller.blackboard[BB_MONKEY_BEST_FORCE_FOUND]

	if(!isturf(living_pawn.loc))
		return FALSE
	if(!target)
		return FALSE
	if(target.anchored)
		return FALSE

	var/our_force = target.rough_combat_value(living_pawn)
	if(our_force > best_force) // better weapon
		living_pawn.drop_all_held_items()
		living_pawn.put_in_hands(target)
		controller.set_blackboard_key(BB_MONKEY_BEST_FORCE_FOUND, our_force)
		return TRUE

	if(living_pawn.put_in_hands(target))
		if(target != living_pawn.get_active_held_item())
			living_pawn.swap_hand(living_pawn.get_held_index_of_item(target))
		return TRUE

	if(target.equip_to_best_slot(living_pawn))
		return TRUE

	return FALSE
