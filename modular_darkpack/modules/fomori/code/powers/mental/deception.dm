/datum/storyteller_roll/deception
	bumper_text = "deception"
	difficulty = 8
	applicable_stats = list(STAT_WITS, STAT_SUBTERFUGE)
	numerical = TRUE
	roll_output_type = ROLL_PRIVATE

/datum/action/cooldown/power/fomori_power/deception
	name = "Deception"
	desc = "Spend a willpower point to disguise your taint from those capable of percieving it."
	button_icon_state = "deception"
	rank = 1 // of 1
	click_to_activate = TRUE
	willpower_cost = 1

/datum/action/cooldown/power/fomori_power/deception/Activate(atom/target)
	if(!isliving(target))
		return FALSE
	if(!(target in range(1, owner)))
		return FALSE

	var/mob/living/victim = target

	. = ..()

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/deception
	var/roll_result = roll_datum.st_roll(owner)

	StartCooldown()
	return TRUE
#warn DECEPTION UNFINISHED
