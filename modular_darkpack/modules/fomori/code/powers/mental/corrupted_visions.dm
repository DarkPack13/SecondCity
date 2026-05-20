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

/datum/action/cooldown/power/fomori_power/corrupted_visions/Activate(atom/target)
	if(!isliving(target))
		return FALSE

	var/mob/living/victim = target

	. = ..()

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/corrupted_visions
	var/roll_result = roll_datum.st_roll(owner)

	to_chat(owner, span_purple("You attempt to induce visions in [target]..."))

	SEND_SOUND(owner, 'modular_darkpack/modules/deprecated/sounds/insanity.ogg')
	SEND_SOUND(victim, 'modular_darkpack/modules/deprecated/sounds/insanity.ogg')


	if(roll_result > 0)
		if(!victim.has_quirk(/datum/quirk/darkpack/derangement))
			victim.add_quirk(/datum/quirk/darkpack/derangement)
			addtimer(CALLBACK(src, PROC_REF(end_visions), victim), roll_result TURNS)
		else
			to_chat(owner, span_warning("[victim] doesn't seem bothered by their visions..."))
			to_chat(victim, span_hypnophrase("The <b>FREAK</b> attempts to disturb the disturbed..."))

	StartCooldown()
	return TRUE

/datum/action/cooldown/power/fomori_power/corrupted_visions/proc/end_visions(mob/living/victim)
	victim.remove_quirk(/datum/quirk/darkpack/derangement)
