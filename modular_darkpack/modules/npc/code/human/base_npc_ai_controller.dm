/datum/ai_controller/npc
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.4 SECONDS
	planning_subtrees = list(
		/datum/ai_planning_subtree/generic_resist,
	)
	blackboard = list(
		BB_RESISTING = FALSE,
	)
	idle_behavior = /datum/idle_behavior/idle_random_walk

