/datum/storyteller_roll/corrupted_visions
	bumper_text = "corrupted visions"
	difficulty = 8
	applicable_stats = list(STAT_MANIPULATION, STAT_SUBTERFUGE)
	numerical = TRUE
	roll_output_type = ROLL_PRIVATE

/datum/action/cooldown/power/fomori_power/corrupted_visions
	name = "Corrupted Visions"
	desc = "Spend a willpower point to induce hallucinations in your prey."
	button_icon_state = "corrupted_visions"
	rank = 1 // of 1
	click_to_activate = TRUE
	willpower_cost = 1

/datum/action/cooldown/power/fomori_power/horns/Activate(atom/target)
	. = ..()
	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/fomor_regeneration
	var/roll_result = roll_datum.st_roll(owner)

	to_chat(owner, span_purple("You attempt to induce visions in [target]..."))

	SEND_SOUND(owner, 'modular_darkpack/modules/deprecated/sounds/insanity.ogg')
	SEND_SOUND(target, 'modular_darkpack/modules/deprecated/sounds/insanity.ogg')


	if(roll_result)
		target.cause_hallucination( \
				get_random_valid_hallucination_subtype(/datum/hallucination/delusion/preset), \
				"corrupted visions", \
				duration = roll_result TURNS, \
				affects_us = FALSE, \
				affects_others = TRUE, \
				skip_nearby = FALSE, \
			)
