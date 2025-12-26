/datum/ai_controller/npc/stand_still
	ai_movement = /datum/ai_movement/jps
	movement_delay = 0.8 SECONDS
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity, // Resist out of cuffs or whatnot first.
		/datum/ai_planning_subtree/target_retaliate, // Then handle combat.
		/datum/ai_planning_subtree/search_for_weapon,
		/datum/ai_planning_subtree/choose_attack_subtree, // End handling combat.
		/datum/ai_planning_subtree/go_home
	)
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = UNCONSCIOUS,
		BB_FLEE_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_REINFORCEMENTS_EMOTE = "presses their radio's emergency button.",
		BB_GUNMIMIC_GUN_EMPTY = FALSE,
		BB_MONKEY_BLACKLISTITEMS = list(),
		BB_HOME_VILLAGE = null
	)
	can_idle = FALSE

/datum/ai_controller/npc/stand_still/New(atom/new_pawn)
	. = ..()
	set_blackboard_key(BB_HOME_VILLAGE, get_turf(new_pawn))

/datum/ai_planning_subtree/go_home
	var/travel_behavior = /datum/ai_behavior/travel_towards/stop_on_arrival/npc

/datum/ai_planning_subtree/go_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(get_turf(controller.pawn) == controller.blackboard[BB_HOME_VILLAGE])
		var/mob/living/nearest_mob = get_closest_atom(/mob/living, oviewers(DEFAULT_SIGHT_DISTANCE, controller.pawn), controller.pawn)
		if(can_see(controller.pawn, nearest_mob, DEFAULT_SIGHT_DISTANCE))
			controller.pawn.dir = get_dir(controller.pawn, nearest_mob)
		return
	if(controller.blackboard_key_exists(BB_TRAVEL_DESTINATION))
		controller.queue_behavior(travel_behavior, BB_TRAVEL_DESTINATION)
		return

	controller.queue_behavior(/datum/ai_behavior/find_home, BB_TRAVEL_DESTINATION)

/datum/ai_behavior/find_home
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION

/datum/ai_behavior/find_home/perform(seconds_per_tick, datum/ai_controller/controller, destination)
	controller.set_blackboard_key(destination, controller.blackboard[BB_HOME_VILLAGE])
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
