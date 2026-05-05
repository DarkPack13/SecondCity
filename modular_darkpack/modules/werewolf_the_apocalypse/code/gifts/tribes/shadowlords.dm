/datum/action/cooldown/power/gift/aura_of_confidence
	name = "Aura of Confidence"
	desc = "The werewolf projects an aura of superiority, preventing attempts to find flaws or read auras."
	#warn no icon
	// button_icon_state = "aura_of_confidence"
	rank = 1

// Effect is permenent
/datum/action/cooldown/power/gift/aura_of_confidence/Grant(mob/granted_to)
	. = ..()
	ADD_TRAIT(granted_to, TRAIT_AURA_OF_CONFIDENCE, GIFT_TRAIT)
	SEND_SIGNAL(granted_to, COMSIG_MOB_UPDATE_AURA)

/datum/action/cooldown/power/gift/aura_of_confidence/Remove(mob/removed_from)
	. = ..()
	REMOVE_TRAIT(removed_from, TRAIT_AURA_OF_CONFIDENCE, GIFT_TRAIT)
	SEND_SIGNAL(removed_from, COMSIG_MOB_UPDATE_AURA)



/datum/storyteller_roll/gift/fatal_flaw
	bumper_text = "Fatal Flaw"
	applicable_stats = list(STAT_PERCEPTION, STAT_EMPATHY)
	numerical = TRUE


/datum/action/cooldown/power/gift/fatal_flaw
	name = "Fatal Flaw"
	desc = "The Shadow Lord can spy a target's weakness, gaining an advantage in combat."
	#warn no icon
	// button_icon_state = "fatal_flaw"
	rank = 1
	click_to_activate = TRUE

/datum/action/cooldown/power/gift/fatal_flaw/Activate(atom/target)
	var/mob/living/carbon/human/human_owner = astype(owner)
	var/mob/living/living_target = astype(target)
	if(!living_target || (living_target == owner))
		return FALSE
	if(!(target in range(DEFAULT_SIGHT_DISTANCE, owner)))
		return FALSE

	. = ..()

	if(!do_after(owner, 1 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_HELD_ITEM)))
		return TRUE

	var/datum/storyteller_roll/gift/fatal_flaw/roll_datum = new()
	roll_datum.difficulty = living_target.st_get_stats(list(STAT_WITS, STAT_SUBTERFUGE))
	var/roll_result = roll_datum.st_roll(owner, target)

	if(roll_result <= 0)
		return TRUE

	return TRUE
