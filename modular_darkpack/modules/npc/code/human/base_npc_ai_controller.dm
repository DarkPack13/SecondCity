/datum/ai_controller/npc
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.4 SECONDS
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/find_nearest_thing_which_attacked_me_to_flee,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/look_for_walk_target
	)
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = UNCONSCIOUS,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)
	idle_behavior = null
