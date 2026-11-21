/proc/aggro_police_npcs(mob/living/criminal, range = DEFAULT_SIGHT_DISTANCE)
	for(var/mob/living/carbon/human/npc/police/P in oviewers(DEFAULT_SIGHT_DISTANCE, criminal))
		P.ai_controller?.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_RETALIATE_LIST, criminal, world.time)

#warn Idk i kinda hate this. this should prob extend beyond just humans. hrm.
/proc/mass_forget_mob(target)
	for(var/mob/living/carbon/human/npc/NPC in GLOB.human_npc_list)
		NPC.ai_controller?.forget_target(target)

/**
 * Mimmicing /datum/ai_controller/proc/forgive_target but for ANY temporary interactions,
 * not just combat. Primarly for abilities that make you disappear or wipe you from there memory.
 **/
/datum/ai_controller/proc/forget_target(atom/target)
	var/static/list/keys_to_check = list(
		BB_CURRENT_TARGET,
		BB_CURRENT_PET_TARGET,
	)
	for(var/key in keys_to_check)
		if(target == blackboard[key])
			clear_blackboard_key(key)
	remove_from_blackboard_lazylist_key(BB_BASIC_MOB_RETALIATE_LIST, target)
