/datum/ai_controller/npc
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.4 SECONDS
	planning_subtrees = list(
		/datum/ai_planning_subtree/generic_resist,
		/datum/ai_planning_subtree/look_for_walk_target,
	)
	blackboard = list(
		BB_RESISTING = FALSE,
		BB_MOVE_TARGET = null
	)
	idle_behavior = /datum/idle_behavior/walk_near_target/npc

/datum/idle_behavior/walk_near_target/npc
	walk_chance = 100
	minimum_distance = 3
	target_key = BB_MOVE_TARGET

///look for our village
/datum/ai_planning_subtree/look_for_walk_target

/datum/ai_planning_subtree/look_for_walk_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard_key_exists(BB_MOVE_TARGET))
		return

	controller.queue_behavior(/datum/ai_behavior/find_target, BB_MOVE_TARGET)

/datum/ai_behavior/find_target
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION

/datum/ai_behavior/find_target/perform(seconds_per_tick, datum/ai_controller/controller, destination)
	var/list/possible_destinations = list()
	for(var/obj/effect/landmark/npcbeacon/random_destination in GLOB.landmarks_list)
		if(random_destination == controller.blackboard[BB_MOVE_TARGET])
			continue
		possible_destinations += random_destination

	var/obj/effect/landmark/destination_marker = pick(possible_destinations)
	if(isnull(destination_marker))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	controller.set_blackboard_key(destination, destination_marker)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
