/datum/ai_controller/npc
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.4 SECONDS
	planning_subtrees = list(
		/datum/ai_planning_subtree/generic_resist,
		/datum/ai_planning_subtree/find_patrol_beacon/npc
	)
	blackboard = list(
		BB_RESISTING = FALSE,
		BB_BEACON_TARGET = null
	)
	idle_behavior = null
