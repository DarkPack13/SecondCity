/datum/storyteller_roll/seizures
	bumper_text = "seizures"
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	difficulty = 8
	successes_needed = 3
	roll_output_type = ROLL_PRIVATE


/datum/quirk/darkpack/seizures
	name = "Seizures"
	#warn needs tweaks
	desc = {"When you're under the gun, you lose control of your body.
	When you botch an important roll, make a Willpower check (difficulty 8).
	Scoring less than three successes makes you writhe uncontrollably until the Storyteller tells you to make another roll.
	You can take no actions while experiencing a seizure."}
	icon = FA_ICON_BRAIN
	value = -4 // Made up since its not a "real" flaw and is instead listed in the crinos-born section
	gain_text = span_warning("You feel less in control of your body...")
	lose_text = span_notice("You feel more in control of yourself.")

/datum/quirk/darkpack/seizures/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_LIVING_DICE_ROLLED, PROC_REF(on_dice_rolled))

/datum/quirk/darkpack/seizures/remove()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_DICE_ROLLED)

/datum/quirk/darkpack/seizures/proc/on_dice_rolled(mob/living/roller, datum/storyteller_roll/roll_datum, output)
	SIGNAL_HANDLER

	if(roll_datum.spammy_roll)
		return

	if(roll_datum.numerical)
		if(output >= 0)
			return
	else
		if(output != ROLL_BOTCH)
			return

	var/datum/storyteller_roll/seizures/roll_datum = new()
	var/result = roll_datum.st_roll(roller)

	if(result == ROLL_SUCCESS)
		return
