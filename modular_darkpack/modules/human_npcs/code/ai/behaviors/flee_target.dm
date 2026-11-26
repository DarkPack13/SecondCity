/datum/bt_node/ai_behavior/acquire_target/npc_flee_target
	target_key = BB_CURRENT_FLEE_TARGET
	target_source = /datum/target_source/oview
	targeting_strategy = /datum/targeting_strategy/find_flee_target
	time_between_perform = 1 SECONDS

/datum/targeting_strategy/find_flee_target/is_valid_target(mob/living/living_mob, atom/target, vision_range, datum/ai_controller/controller = null)
	. = ..()
	if(!.)
		return FALSE

	if(isnull(controller))
		return FALSE

	if(prob(controller.get_npc_attribute(BB_HUMAN_ATTRIBUTE_CONFIDENCE)))
		return FALSE

	if(istype(target, /obj/effect/abstract/turf_fire))
		return TRUE

	if(astype(target, /mob/living/carbon/human)?.on_fire)
		return TRUE

	return FALSE
