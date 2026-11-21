/datum/ai_controller/npc
	ai_movement = /datum/ai_movement/basic_avoidance // /datum/ai_movement/jps
	movement_delay = 0.8 SECONDS

	ai_traits = parent_type::ai_traits | RUN_WHILE_UNWATCHED

	behavior_tree_json = "modular_darkpack/modules/human_npcs/code/ai/npc.bt.json"
	/*
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity, // Resist out of cuffs or whatnot first.
		/datum/ai_planning_subtree/find_nearest_thing_which_attacked_me_to_flee, // Then handle combat.
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/flee_target, // End handling combat.
		/datum/ai_planning_subtree/look_for_walk_target // Random walking behavior.
	)
	*/
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = SOFT_CRIT,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_REINFORCEMENTS_SAY = "HELP!!!",
		BB_MONKEY_BLACKLISTITEMS = list(),
	)

/datum/ai_controller/npc/PossessPawn(atom/new_pawn)
	if(!isliving(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE
	RegisterSignal(new_pawn, COMSIG_MOB_MOVESPEED_UPDATED, PROC_REF(update_movespeed))

	var/mob/living/living_pawn = new_pawn
	movement_delay = living_pawn.cached_multiplicative_slowdown
	return ..() //Run parent at end

/datum/ai_controller/npc/proc/update_movespeed(mob/living/pawn)
	SIGNAL_HANDLER
	movement_delay = pawn.cached_multiplicative_slowdown

/datum/ai_controller/npc/on_stat_changed(mob/living/source, new_stat)
	. = ..()
	update_able_to_run()

/datum/ai_controller/npc/setup_able_to_run()
	. = ..()
	RegisterSignal(pawn, COMSIG_MOB_INCAPACITATE_CHANGED, PROC_REF(update_able_to_run))

/datum/ai_controller/npc/clear_able_to_run()
	UnregisterSignal(pawn, list(COMSIG_MOB_INCAPACITATE_CHANGED, COMSIG_MOB_STATCHANGE))
	return ..()

/datum/ai_controller/npc/get_able_to_run()
	var/mob/living/living_pawn = pawn

	if(INCAPACITATED_IGNORING(living_pawn, INCAPABLE_RESTRAINTS|INCAPABLE_STASIS|INCAPABLE_GRAB))
		return AI_UNABLE_TO_RUN
	return ..()


/datum/ai_controller/proc/get_npc_attribute(target_key)
	if(target_key in blackboard)
		return blackboard[target_key]
	return 50 // Average.


/datum/bt_node/subtree/npc_combat
	behavior_tree_json = "modular_darkpack/modules/human_npcs/code/ai/npc_combat.bt.json"
