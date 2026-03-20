/datum/storyteller_roll/gift/mothers_touch
	applicable_stats = list(STAT_INTELLIGENCE, STAT_EMPATHY)
	numerical = TRUE

/*
From W20 p. 164
Mother's Touch
System: The player spends one Gnosis point and rolls
Intelligence + Empathy (difficulty is the target’s current
Rage, or 5 for those with no Rage). Each success heals one
level of lethal, bashing, or aggravated damage. The healer
may even heal fresh Battle Scars (see p. 259) in this man-
ner, if the Gift is applied during the same scene in which
the scar is received and an extra Gnosis point is spent.
*/
/datum/action/cooldown/power/gift/mothers_touch
	name = "Mother's Touch"
	desc = "The Garou is able to heal the wounds of any living creature, aggravated or otherwise, simply by laying hands over the afflicted area."
	button_icon_state = "mothers_touch"
	click_to_activate = TRUE
	rank = 1

	//rage_cost = 1
	gnosis_cost = 1

/datum/action/cooldown/power/gift/mothers_touch/Activate(atom/target)
	if(!isliving(target))
		return
	if(!(target in range(1, owner)))
		return

	. = ..()

	var/datum/splat/werewolf/werewolf_splat = get_werewolf_splat(owner)
	var/difficulty = werewolf_splat.uses_rage ? werewolf_splat.rage : 5
	var/successes = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/gift/mothers_touch, difficulty = difficulty)

	var/mob/living/living_target = target
	living_target.heal_storyteller_health(successes, TRUE, TRUE, TRUE)

	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	StartCooldown()
	return TRUE

// Sense Wyrm

/datum/action/cooldown/power/gift/spirit_speech
	name = "Spirit Speech"
	desc = "This Gift allows the Garou to communicate with encountered spirits."
	button_icon_state = "spirit_speech"
	rank = 1

/datum/action/cooldown/power/gift/spirit_speech/Grant(mob/granted_to)
	. = ..()
	ADD_TRAIT(granted_to, TRAIT_LOCAL_SIXTHSENSE, GIFT_TRAIT)

/datum/action/cooldown/power/gift/spirit_speech/Activate(atom/target)
	. = ..()

	if(HAS_TRAIT_FROM(owner, TRAIT_LOCAL_SIXTHSENSE, GIFT_TRAIT))
		REMOVE_TRAIT(owner, TRAIT_LOCAL_SIXTHSENSE, GIFT_TRAIT)
		to_chat(owner, span_notice("You deactivate [name]."))
	else
		ADD_TRAIT(owner, TRAIT_LOCAL_SIXTHSENSE, GIFT_TRAIT)
		to_chat(owner, span_notice("You activate [name]."))

/datum/action/cooldown/power/gift/spirit_speech/Remove(mob/removed_from)
	. = ..()
	REMOVE_TRAIT(removed_from, TRAIT_LOCAL_SIXTHSENSE, GIFT_TRAIT)
