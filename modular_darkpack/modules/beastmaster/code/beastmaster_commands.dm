//custom pet commands
/datum/pet_command/attack/beastmaster
	targeting_strategy_key = BB_PET_TARGETING_STRATEGY

/datum/pet_command/attack/beastmaster/on_target_set(mob/living/friend, atom/potential_target)
	var/mob/living/parent = weak_parent.resolve()
	if(!parent)
		return FALSE

	// dont attack random atoms like sand
	if(!isliving(potential_target))
		return FALSE

	var/mob/living/living_target = potential_target

	// an AI controller is necessary
	if(!parent.ai_controller)
		return FALSE

	// don't attack friends
	var/list/friends = parent.ai_controller.blackboard[BB_FRIENDS_LIST]
	if(friends && (living_target in friends))
		to_chat(friend, span_warning("[parent] refuses to attack [living_target]!"))
		return FALSE

	// don't attack dead things
	if(living_target.stat == DEAD)
		return FALSE

	parent.ai_controller.CancelActions()

	parent.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, living_target)
	parent.ai_controller.set_blackboard_key(BB_CURRENT_PET_TARGET, living_target)
	parent.ai_controller.set_blackboard_key(BB_ACTIVE_PET_COMMAND, src)
	parent.visible_message(span_warning("[parent] follows [friend]'s gesture towards [living_target] [pointed_reaction]!"))
	return TRUE

/datum/pet_command/attack/beastmaster/execute_action(datum/ai_controller/controller)
	var/mob/living/target = controller.blackboard[BB_CURRENT_PET_TARGET]
	if(!target)
		return
	controller.queue_behavior(/datum/ai_behavior/basic_melee_attack, BB_CURRENT_PET_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

//just let them do whatever they want - this overrides the parent command because we want them not just to clear all commands but also clear the target so they stop attacking.
/datum/pet_command/free/beastmaster

/datum/pet_command/free/beastmaster/execute_action(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
	controller.clear_blackboard_key(BB_CURRENT_PET_TARGET)
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	return
