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

	// an ai controller is necessary
	if(!parent.ai_controller)
		return FALSE

	// don't attack friends
	var/list/friends = parent.ai_controller.blackboard[BB_FRIENDS_LIST]
	if(friends && (living_target in friends))
		to_chat(friend, span_warning("[parent] refuses to attack [living_target]!"))
		return FALSE

	// don't attack the summoner
	if(living_target == friend)
		to_chat(friend, span_warning("[parent] refuses to attack you!"))
		return FALSE

	// don't attack dead things
	if(living_target.stat == DEAD)
		return FALSE

	// add to enemies list for persistent targeting
	var/list/enemies = parent.ai_controller.blackboard[BB_BEASTMASTER_ENEMIES_LIST]
	if(!islist(enemies))
		enemies = list()
		parent.ai_controller.blackboard[BB_BEASTMASTER_ENEMIES_LIST] = enemies

	if(!(living_target in enemies))
		enemies += living_target
		RegisterSignal(living_target, COMSIG_LIVING_DEATH, PROC_REF(on_enemy_death), override = TRUE)

	parent.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, living_target)
	parent.ai_controller.set_blackboard_key(BB_CURRENT_PET_TARGET, living_target)
	parent.ai_controller.set_blackboard_key(BB_ACTIVE_PET_COMMAND, src)
	parent.visible_message(span_warning("[parent] follows [friend]'s gesture towards [living_target] [pointed_reaction]!"))
	return TRUE

/datum/pet_command/attack/beastmaster/execute_action(datum/ai_controller/controller)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]

	// if current target is invalid, find a new one from enemies list
	if(!target || target.stat == DEAD)
		var/list/enemies = controller.blackboard[BB_BEASTMASTER_ENEMIES_LIST]
		if(enemies && length(enemies))
			for(var/mob/living/enemy in enemies)
				if(!QDELETED(enemy) && enemy.stat != DEAD)
					target = enemy
					controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
					controller.set_blackboard_key(BB_CURRENT_PET_TARGET, target)
					break

		// no valid targets, clear everything
		if(!target)
			controller.clear_blackboard_key(BB_CURRENT_PET_TARGET)
			controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
			return

	// attack the target
	controller.queue_behavior(attack_behaviour, BB_BASIC_MOB_CURRENT_TARGET, targeting_strategy_key)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/pet_command/attack/beastmaster/proc/on_enemy_death(mob/living/dead_enemy)
	SIGNAL_HANDLER
	var/mob/living/parent = weak_parent.resolve()
	if(!parent?.ai_controller)
		return

	// remove from enemies list
	var/list/enemies = parent.ai_controller.blackboard[BB_BEASTMASTER_ENEMIES_LIST]
	if(enemies)
		enemies -= dead_enemy

	UnregisterSignal(dead_enemy, COMSIG_LIVING_DEATH)

	// if this was our current target, clear it
	if(parent.ai_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] == dead_enemy)
		parent.ai_controller.clear_blackboard_key(BB_CURRENT_PET_TARGET)
		parent.ai_controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)

/datum/pet_command/free/beastmaster

/datum/pet_command/free/beastmaster/execute_action(datum/ai_controller/controller)
	// clear all commands
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
	controller.clear_blackboard_key(BB_CURRENT_PET_TARGET)
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)

	// clear enemies list and unregister signals
	var/list/enemies = controller.blackboard[BB_BEASTMASTER_ENEMIES_LIST]
	if(enemies)
		for(var/mob/living/enemy in enemies)
			UnregisterSignal(enemy, COMSIG_LIVING_DEATH)
		enemies.Cut()

	controller.CancelActions()
	return
