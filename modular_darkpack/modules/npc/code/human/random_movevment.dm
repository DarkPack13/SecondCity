/datum/ai_planning_subtree/find_patrol_beacon/npc
	travel_behavior = /datum/ai_behavior/travel_towards/beacon/npc

/datum/ai_planning_subtree/find_patrol_beacon/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard[BB_BOT_BEACON_COOLDOWN] > world.time)
		return

	if(controller.blackboard_key_exists(BB_BEACON_TARGET))
		controller.queue_behavior(travel_behavior, BB_BEACON_TARGET)
		return

	if(controller.blackboard_key_exists(BB_PREVIOUS_BEACON_TARGET))
		controller.queue_behavior(/datum/ai_behavior/find_next_beacon_target, BB_BEACON_TARGET)
		return

	controller.queue_behavior(/datum/ai_behavior/find_first_beacon_target, BB_BEACON_TARGET)

/datum/ai_behavior/travel_towards/beacon/npc
	new_movement_type = /datum/ai_movement/jps/npc

/datum/ai_movement/jps/npc
	diagonal_flags = DIAGONAL_REMOVE_CLUNKY
	maximum_length = AI_BOT_PATH_LENGTH
	max_pathing_attempts = 10
