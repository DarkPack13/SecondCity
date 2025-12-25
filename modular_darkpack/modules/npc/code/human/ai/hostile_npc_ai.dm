/datum/ai_controller/npc/hostile
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity, // Resist out of cuffs or whatnot first.
		/datum/ai_planning_subtree/target_retaliate, // Then handle combat.
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/basic_melee_attack_subtree, // End handling combat.
		/datum/ai_planning_subtree/look_for_walk_target // Random walking behavior.
	)
