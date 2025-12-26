/datum/ai_planning_subtree/choose_attack_subtree

/datum/ai_planning_subtree/choose_attack_subtree/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/carbon/human/human_pawn = controller.pawn

	if(human_pawn.is_holding_item_of_type(/obj/item/gun))
		if(controller.blackboard[BB_GUNMIMIC_GUN_EMPTY])
			return
		var/datum/ai_planning_subtree/basic_ranged_attack_subtree/npc/ranged_attack_subtree = GLOB.ai_subtrees[/datum/ai_planning_subtree/basic_ranged_attack_subtree]
		ranged_attack_subtree.SelectBehaviors(controller, seconds_per_tick)

	var/datum/ai_planning_subtree/basic_melee_attack_subtree/melee_attack_subtree = GLOB.ai_subtrees[/datum/ai_planning_subtree/basic_melee_attack_subtree]
	melee_attack_subtree.SelectBehaviors(controller, seconds_per_tick)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/npc
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/npc

/datum/ai_behavior/basic_ranged_attack/npc
	action_cooldown = 3 SECONDS
	avoid_friendly_fire = TRUE
