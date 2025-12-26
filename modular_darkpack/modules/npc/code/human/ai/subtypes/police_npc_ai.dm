/datum/ai_controller/npc/police
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity, // Resist out of cuffs or whatnot first.
		/datum/ai_planning_subtree/target_retaliate, // Then handle combat.
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/search_for_weapon,
		/datum/ai_planning_subtree/choose_attack_subtree, // End handling combat.
		/datum/ai_planning_subtree/look_for_walk_target // Random walking behavior.
	)
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = UNCONSCIOUS,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_REINFORCEMENTS_EMOTE = "presses their radio's emergency button.",
		BB_GUNMIMIC_GUN_EMPTY = FALSE,
		BB_MONKEY_BLACKLISTITEMS = list(),
	)
