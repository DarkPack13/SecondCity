/datum/storyteller_roll/eyes_of_the_wyrm // For defending
	bumper_text = "eyes_of_the_wyrm"
	difficulty = 8
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	roll_output_type = ROLL_PRIVATE

/datum/action/cooldown/power/fomori_power/eyes_of_the_wyrm
	name = "Eyes of the Wyrm"
	desc = "(UNFINISHED) Shock your prey into immobility with the Wyrm's Damnation."
	button_icon_state = "eyes_of_the_wyrm"
	rank = 1 // of 1
	click_to_activate = TRUE
	willpower_cost = 1

/datum/action/cooldown/power/fomori_power/eyes_of_the_wyrm/Activate(atom/target)
	if(!isliving(target))
		return FALSE
	if(!(target in range(1, owner)))
		return FALSE

	var/mob/living/victim = target

	. = ..()

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/eyes_of_the_wyrm
	var/roll_result = roll_datum.st_roll(victim)

	if(roll_result != ROLL_SUCCESS)

	StartCooldown()
	return TRUE

#warn EYES OF THE WYRM UNFINISHED
