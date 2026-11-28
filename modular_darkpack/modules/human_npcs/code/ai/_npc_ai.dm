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

	COOLDOWN_DECLARE(car_dodge)

/datum/ai_controller/npc/PossessPawn(atom/new_pawn)
	if(!isliving(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE
	RegisterSignal(new_pawn, COMSIG_MOB_MOVESPEED_UPDATED, PROC_REF(update_movespeed))

	var/mob/living/living_pawn = new_pawn
	movement_delay = living_pawn.cached_multiplicative_slowdown

	RegisterSignal(new_pawn, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_attacked))
	RegisterSignal(new_pawn, COMSIG_LIVING_START_PULL, PROC_REF(on_startpulling))
	RegisterSignals(new_pawn, list(COMSIG_LIVING_TRY_SYRINGE_INJECT, COMSIG_LIVING_TRY_SYRINGE_WITHDRAW), PROC_REF(on_try_syringe))
	RegisterSignal(new_pawn, COMSIG_CARBON_CUFF_ATTEMPTED, PROC_REF(on_attempt_cuff))
	// Annoy the NPC when pushed around
	RegisterSignal(new_pawn, COMSIG_LIVING_MOB_BUMPED, PROC_REF(handle_bumped))
	// Be annoyed if helped
	RegisterSignal(new_pawn, COMSIG_CARBON_HELP_ACT, PROC_REF(handle_helped))

	RegisterSignal(new_pawn, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

	return ..() //Run parent at end

/datum/ai_controller/npc/UnpossessPawn(destroy)
	UnregisterSignal(pawn, list(
		COMSIG_MOB_MOVESPEED_UPDATED,
		COMSIG_ATOM_WAS_ATTACKED,
		COMSIG_LIVING_START_PULL,
		COMSIG_LIVING_TRY_SYRINGE_INJECT,
		COMSIG_LIVING_TRY_SYRINGE_WITHDRAW,
		COMSIG_CARBON_CUFF_ATTEMPTED,
		COMSIG_LIVING_MOB_BUMPED,
		COMSIG_CARBON_HELP_ACT,
	))

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

/*
/mob/living/carbon/human/npc/proc/handle_attacked(datum/source, atom/attacker, attack_flags)
	// Only aggro nearby npcs if its lethal.
	if(!(attack_flags & (ATTACKER_STAMINA_ATTACK|ATTACKER_SHOVING)))
		for(var/mob/living/carbon/human/npc/nearby_npcs in oviewers(DEFAULT_SIGHT_DISTANCE, src))
			nearby_npcs.aggro_npc(attacker)
		SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_FIREFIGHT, get_turf(src))
	aggro_npc(attacker, TRUE)
*/

///Reactive events to being hit
/datum/ai_controller/npc/proc/retaliate(mob/living/living_mob)
	// just to be safe
	if(QDELETED(living_mob))
		return

	change_npc_reputation(living_mob, -25)
	// add_blackboard_key_assoc(BB_MONKEY_ENEMIES, living_mob, MONKEY_HATRED_AMOUNT)

#warn move to setting bb key and reacting with behavoir node
/datum/ai_controller/npc/proc/react_annoyed(mob/living/annoyer)
	if(!able_to_run)
		return

	change_npc_reputation(annoyer, -5)
	set_blackboard_key(BB_LAST_ANNOYED, world.time)
	set_blackboard_key(BB_CURRENT_ANNOYER, annoyer)

/datum/ai_controller/npc/proc/on_attacked(datum/source, mob/attacker, attack_flags)
	SIGNAL_HANDLER

	if(attack_flags & ATTACKER_DAMAGING_ATTACK)
		alert_crime_bystanders(CRIME_BATTERY, pawn, attacker)
		if((get_npc_reputation(attacker) < 100) && prob(get_npc_attribute(BB_HUMAN_ATTRIBUTE_AGGRESSION) * 1.5))
			retaliate(attacker)
	else
		if((get_npc_reputation(attacker) < 75) && prob(get_npc_attribute(BB_HUMAN_ATTRIBUTE_AGGRESSION) * 1.5))
			retaliate(attacker)

/datum/ai_controller/npc/proc/on_startpulling(datum/source, atom/movable/puller, state, force)
	SIGNAL_HANDLER
	var/mob/living/living_pawn = pawn
	if(get_npc_reputation(living_pawn.pulledby) >= 75)
		return

	if(!living_pawn.incapacitated && prob(get_npc_attribute(BB_HUMAN_ATTRIBUTE_AGGRESSION) * 0.75)) // nuh uh you don't pull me!
		retaliate(living_pawn.pulledby)
		return TRUE
	else
		react_annoyed(living_pawn.pulledby)
		return TRUE

/datum/ai_controller/npc/proc/on_try_syringe(datum/source, mob/user)
	SIGNAL_HANDLER
	if(get_npc_reputation(user) >= 100)
		return
	// chance of monkey retaliation
	if(prob(MONKEY_SYRINGE_RETALIATION_PROB))
		retaliate(user)
	else
		react_annoyed(user)

/datum/ai_controller/npc/proc/on_attempt_cuff(datum/source, mob/user)
	SIGNAL_HANDLER

	if(get_npc_reputation(user) >= 100)
		return
	// chance of monkey retaliation
	if(prob(get_npc_attribute(BB_HUMAN_ATTRIBUTE_AGGRESSION) * 1.5))
		retaliate(user)
	else
		react_annoyed(user)

/datum/ai_controller/npc/proc/handle_bumped(mob/living/carbon/human/npc/source, mob/living/bumping)
	SIGNAL_HANDLER

	if(get_npc_reputation(bumping) >= 75)
		return

	if (bumping.can_mobswap_with(source) && prob(25))
		return

	react_annoyed(bumping)

/datum/ai_controller/npc/proc/handle_helped(mob/living/carbon/human/npc/source, mob/living/helper)
	SIGNAL_HANDLER

	if(get_npc_reputation(helper) >= 75)
		return

	react_annoyed(helper)


/datum/ai_controller/npc/proc/on_examine(atom/movable/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/user_reputation = get_npc_reputation(user)
	if(!isnull(user_reputation) && (user != source))
		examine_list += span_notice("They think your [EXAMINE_HINT("[user_reputation]")]/100.")


/datum/ai_controller/proc/get_npc_attribute(target_key)
	if(target_key in blackboard)
		return blackboard[target_key]
	return 50 // Average.

/datum/ai_controller/proc/get_npc_reputation(mob/living/target, target_key = BB_HUMAN_ASSOC_ATTRIBUTE_REPUTATION)
	if(target == pawn)
		return 100 // Thats me..

	. = 0

	var/atom/movable/movable_pawn = astype(pawn)
	if(movable_pawn?.faction_check_atom(target))
		. += 25

	var/mob/living/carbon/human/human_target = astype(target)
	if(human_target)
		// Should add a check for if im a criminal..
		if(human_target.wear_id && istype(human_target.wear_id, /obj/item/card/police))
			. += 25
		if(ismundane(pawn) && human_target.wear_id && istype(human_target.wear_id, /obj/item/card/clinic))
			. += 25

	if(target_key in blackboard)
		. += blackboard[target_key][target]
	else
		. += 50 // Average. Because we have no other opinion yet.


/datum/ai_controller/proc/change_npc_reputation(mob/living/target, reputation_change, target_key = BB_HUMAN_ASSOC_ATTRIBUTE_REPUTATION)
	if(target == pawn)
		return // Thats me..

	if(!(target_key in blackboard))
		set_blackboard_key_assoc_lazylist(target_key, target, 50 + reputation_change)
		return

	add_blackboard_key_assoc_lazylist(target_key, target, reputation_change)


/datum/bt_node/subtree/npc_combat
	behavior_tree_json = "modular_darkpack/modules/human_npcs/code/ai/npc_combat.bt.json"


#warn do
/*
/datum/ai_controller/npc/PossessPawn(atom/new_pawn)
	RegisterSignal(new_pawn, COMSIG_MOB_CAR_NEAR_IMPACT, PROC_REF(car_near_impact))

/datum/ai_controller/npc/proc/car_near_impact()
	handle_npc_dodge_or_some_shit()
*/
