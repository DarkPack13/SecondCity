/datum/ai_behavior/travel_towards/stop_on_arrival/npc
	new_movement_type = /datum/ai_movement/jps/npc

/datum/ai_movement/jps/npc
	diagonal_flags = DIAGONAL_REMOVE_CLUNKY
	maximum_length = AI_BOT_PATH_LENGTH
	max_pathing_attempts = 10

///look for our npc beacon
/datum/ai_planning_subtree/look_for_walk_target
	var/travel_behavior = /datum/ai_behavior/travel_towards/stop_on_arrival/npc

/datum/ai_planning_subtree/look_for_walk_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard_key_exists(BB_TRAVEL_DESTINATION))
		controller.queue_behavior(travel_behavior, BB_TRAVEL_DESTINATION)
		return

	controller.queue_behavior(/datum/ai_behavior/find_target, BB_TRAVEL_DESTINATION)

/datum/ai_behavior/find_target
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	var/list/past_destinations = list()

/datum/ai_behavior/find_target/perform(seconds_per_tick, datum/ai_controller/controller, destination)
	var/list/possible_destinations = list()
	for(var/obj/effect/landmark/npcbeacon/random_destination in GLOB.landmarks_list)
		if(random_destination == controller.blackboard[BB_TRAVEL_DESTINATION])
			continue
		if(random_destination in past_destinations)
			continue
		possible_destinations += random_destination

	if(!length(possible_destinations))
		return AI_BEHAVIOR_FAILED

	var/obj/effect/landmark/destination_marker = pick(possible_destinations)
	if(isnull(destination_marker))
		return AI_BEHAVIOR_FAILED

	if(length(past_destinations) >= 5)
		past_destinations -= past_destinations[1]
	past_destinations += destination_marker

	controller.set_blackboard_key(destination, destination_marker)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
