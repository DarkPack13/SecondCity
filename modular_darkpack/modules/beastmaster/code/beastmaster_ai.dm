//the custom ai_controller for all beastmaster summons used in our codebase.
/datum/ai_controller/basic_controller/beastmaster_summon
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
	)
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/target_retaliate/beastmaster,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

//custom retaliate subtree that overrides selectbehaviors
/datum/ai_planning_subtree/target_retaliate/beastmaster
	operational_datums = list()

/datum/ai_planning_subtree/target_retaliate/beastmaster/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/datum/pet_command/active_command = controller.blackboard[BB_ACTIVE_PET_COMMAND]
	if(active_command)
		return

	var/current_target_ref = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!current_target_ref)
		return ..()

	//resolve weakrefs if needed
	var/mob/living/current_target
	if(istype(current_target_ref, /datum/weakref))
		var/datum/weakref/ref = current_target_ref
		current_target = ref.resolve()
	else if(isliving(current_target_ref))
		current_target = current_target_ref

	//clear target if it's a friend
	if(current_target)
		var/list/friends = controller.blackboard[BB_FRIENDS_LIST]
		if(friends && (current_target in friends))
			controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
			controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
			return

	return ..()
