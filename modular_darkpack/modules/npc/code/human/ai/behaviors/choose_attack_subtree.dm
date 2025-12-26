/datum/ai_planning_subtree/choose_attack_subtree

/datum/ai_planning_subtree/choose_attack_subtree/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/carbon/human/human_pawn = controller.pawn

	if(human_pawn.is_holding_item_of_type(/obj/item/gun))
		if(controller.blackboard[BB_GUNMIMIC_GUN_EMPTY])
			controller.queue_behavior(/datum/ai_behavior/find_weapon)
			return
		var/datum/ai_planning_subtree/basic_ranged_attack_subtree/npc/ranged_attack_subtree = GLOB.ai_subtrees[/datum/ai_planning_subtree/basic_ranged_attack_subtree]
		ranged_attack_subtree.SelectBehaviors(controller, seconds_per_tick)

	var/datum/ai_planning_subtree/basic_melee_attack_subtree/npc/melee_attack_subtree = GLOB.ai_subtrees[/datum/ai_planning_subtree/basic_melee_attack_subtree]
	melee_attack_subtree.SelectBehaviors(controller, seconds_per_tick)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/npc
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/npc

/datum/ai_behavior/basic_ranged_attack/npc
	action_cooldown = 3 SECONDS
	avoid_friendly_fire = TRUE

/datum/ai_planning_subtree/basic_melee_attack_subtree/npc
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/npc
	end_planning = FALSE

/datum/ai_behavior/basic_melee_attack/npc
	action_cooldown = 0.2 SECONDS // We gotta check unfortunately often because we're in a race condition with nextmove
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION | AI_BEHAVIOR_REQUIRE_REACH
