/*
/datum/bt_node/ai_behavior/travel_towards/stop_on_arrival/npc
	new_movement_type = /datum/ai_movement/jps/npc

/datum/ai_movement/jps/npc
	diagonal_flags = DIAGONAL_REMOVE_CLUNKY
	maximum_length = AI_BOT_PATH_LENGTH
	max_pathing_attempts = 10

///look for our npc beacon
/datum/ai_planning_subtree/look_for_walk_target
	var/travel_behavior = /datum/bt_node/ai_behavior/travel_towards/stop_on_arrival/npc

/datum/ai_planning_subtree/look_for_walk_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard_key_exists(BB_TRAVEL_DESTINATION))
		controller.queue_behavior(travel_behavior, BB_TRAVEL_DESTINATION)
		return

	controller.queue_behavior(/datum/bt_node/ai_behavior/find_target, BB_TRAVEL_DESTINATION)

/datum/bt_node/ai_behavior/find_target
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	var/list/past_destinations = list()

/datum/bt_node/ai_behavior/find_target/perform(seconds_per_tick, datum/ai_controller/controller, destination)
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
*/


/datum/bt_node/ai_behavior/find_npcbeacon
	/// Blackboard key to store the found landmark.
	var/target_key = BB_TRAVEL_DESTINATION
	var/stale_target_key = BB_HUMAN_STALE_BEACONS

/datum/bt_node/ai_behavior/find_npcbeacon/perform(seconds_per_tick, datum/ai_controller/controller)
	/*
	if(controller.blackboard[target_key])
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	*/
	if(!prob(controller.get_npc_attribute(BB_HUMAN_ATTRIBUTE_ENERGY)))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/list/past_destinations = controller.blackboard[stale_target_key]

	var/list/possible_destinations = list()
	if(!GLOB.npc_beacons["[controller.pawn.z]"])
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	for(var/obj/effect/landmark/npcbeacon/random_destination in GLOB.npc_beacons["[controller.pawn.z]"])
		if(random_destination == controller.blackboard[target_key])
			continue
		if(random_destination in past_destinations)
			continue
		possible_destinations += random_destination

	if(!length(possible_destinations))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/obj/effect/landmark/destination_marker = pick(possible_destinations)
	if(isnull(destination_marker))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	if(length(past_destinations) >= 5 || length(past_destinations) >= length(GLOB.npc_beacons["[controller.pawn.z]"]))
		controller.remove_from_blackboard_lazylist_key(stale_target_key, past_destinations[1])
	controller.insert_blackboard_key_lazylist(stale_target_key, destination_marker)

	controller.set_blackboard_key(target_key, destination_marker)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
