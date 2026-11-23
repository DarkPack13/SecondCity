/// Gathers weapon upgrade candidates
/datum/target_source/human_weapon_upgrade

/datum/target_source/human_weapon_upgrade/collect_candidates(mob/living/pawn, datum/ai_controller/controller, range)
	var/list/candidates = list()
	for(var/obj/item/ground_item in oview(range, pawn))
		candidates += ground_item

	for(var/obj/item/worn_item in pawn.get_equipped_items(INCLUDE_POCKETS))
		candidates |= worn_item
		if(istype(worn_item, /obj/item/storage/backpack)) // 100% a better way to do this....
			for(var/obj/item/backpack_content in worn_item.contents)
				candidates |= backpack_content

	var/offhand = pawn.get_inactive_held_item()
	if(offhand)
		candidates += offhand

	return candidates

/// Weapon upgrade candidate: not two-handed, not blacklisted, and hits harder than our brawl.
/datum/targeting_strategy/human_weapon_upgrade

/datum/targeting_strategy/human_weapon_upgrade/is_valid_target(mob/living/living_mob, atom/target, vision_range, datum/ai_controller/controller = null)
	. = ..()
	if(!.)
		return FALSE
	var/obj/item/candidate = target
	/*
	if(HAS_TRAIT(candidate, TRAIT_NEEDS_TWO_HANDS) || controller.blackboard[BB_MONKEY_BLACKLISTITEMS][candidate])
		return FALSE
	*/
	if(controller.blackboard[BB_MONKEY_BLACKLISTITEMS][candidate])
		return FALSE

	if(isgun(candidate) && (living_mob.st_get_stat(STAT_FIREARMS) > 0))
		return TRUE

	if(candidate.force < 3) // True dogshit
		return FALSE

	var/weapon_value = candidate.rough_combat_value(living_mob)
	if(weapon_value < living_mob.rough_combat_value())
		return FALSE

	return TRUE


/// Scans nearby items and mobs for a better weapon and sets BB_MONKEY_PICKUPTARGET
/datum/bt_node/ai_behavior/acquire_target/update_interaction_target/human_find_weapon
	target_source = /datum/target_source/human_weapon_upgrade
	targeting_strategy = /datum/targeting_strategy/human_weapon_upgrade

/datum/bt_node/ai_behavior/acquire_target/update_interaction_target/human_find_weapon/can_search(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	if(!living_pawn.is_holding_items())
		controller.set_blackboard_key(BB_MONKEY_BEST_FORCE_FOUND, 0)
	if((living_pawn.st_get_stat(STAT_FIREARMS) > 0) && living_pawn.is_holding_item_of_type(/obj/item/gun))
		return FALSE // already have a gun
	return ..()

/// Prefers any gun once gun neurons are activated, else the strongest candidate that beats our current best held item.
/datum/bt_node/ai_behavior/acquire_target/update_interaction_target/human_find_weapon/pick_final_target(datum/ai_controller/controller, list/filtered_targets, datum/target_priority_strategy/priority_strategy, atom/current_target)
	var/mob/living/living_pawn = controller.pawn

	if(living_pawn.st_get_stat(STAT_FIREARMS) > 0)
		for(var/obj/item/candidate as anything in filtered_targets)
			if(isgun(candidate))
				return candidate

	var/top_force = 0
	for(var/obj/item/held as anything in living_pawn.get_held_items())
		/*
		if(HAS_TRAIT(held, TRAIT_NEEDS_TWO_HANDS) || controller.blackboard[BB_MONKEY_BLACKLISTITEMS][held])
			continue
		*/
		if(controller.blackboard[BB_MONKEY_BLACKLISTITEMS][held])
			continue
		top_force = max(top_force, held.rough_combat_value(living_pawn))

	var/obj/item/best
	for(var/obj/item/candidate as anything in filtered_targets)
		var/candidate_force = candidate.rough_combat_value(living_pawn)
		if(candidate_force <= top_force)
			continue
		best = candidate
		top_force = candidate_force
	return best


/mob/living/proc/rough_combat_value()
	. = 0

	. += st_get_stat(list(STAT_DEXTERITY, STAT_BRAWL, STAT_STRENGTH))

/// Returns a very rough value of how good it is in combat to weigh against other options.
/obj/item/proc/rough_combat_value(mob/living/user)
	. = 0

	. -= (attack_difficulty - 6)

	. += FORCE_TO_DICE_POOL(force)

	if(damtype == AGGRAVATED)
		. += 2

	if(user)
		. += user.st_get_stats(list(st_attack_ability, st_attack_attribute, st_damage_stat))
