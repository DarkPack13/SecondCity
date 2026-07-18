/datum/storyteller_roll/eyes_of_the_wyrm // For defending // Freak Legion pg.32-33
	bumper_text = "willpower"
	difficulty = 8
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	roll_output_type = ROLL_PRIVATE

/datum/action/cooldown/power/fomori_power/eyes_of_the_wyrm
	name = "Eyes of the Wyrm"
	desc = "Spend a willpower point to shock your prey into immobility with the Wyrm's Damnation. You cannot fight for a short time afterwards."
	button_icon_state = "eyes_of_the_wyrm"
	rank = 1 // of 1
	click_to_activate = TRUE

/datum/action/cooldown/power/fomori_power/eyes_of_the_wyrm/Activate(atom/target) // TODO: "The fomor itself cannot attack its victim, but its friends can."
	if(!isliving(target))
		return FALSE
	if(!(target in range(3, owner)))
		return FALSE
	if(HAS_TRAIT(owner, TRAIT_NO_EYE_CONTACT))
		to_chat(owner, span_warning("You are unable to make eye contact!"))
		return FALSE

	var/mob/living/carbon/victim = target
	var/mob/living/attacker = owner

	. = ..()

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/eyes_of_the_wyrm
	var/roll_result = roll_datum.st_roll(victim)

	var/victim_timer_calc = 5 TURNS - victim.st_get_stat(STAT_WITS)
	var/attacker_timer_calc = 5 TURNS - attacker.st_get_stat(STAT_WITS)
	if(roll_result != ROLL_SUCCESS)
		victim.Stun(victim_timer_calc)
		ADD_TRAIT(attacker, TRAIT_PACIFISM, "eyes_of_the_wyrm")
		to_chat(attacker, span_warning("The Wyrm's corruption spilling forth from your gaze prevents you from harming your target."))
		addtimer(CALLBACK(src, PROC_REF(depacifist)), attacker_timer_calc)
	StartCooldown()
	return TRUE

/datum/action/cooldown/power/fomori_power/eyes_of_the_wyrm/proc/depacifist()
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, "eyes_of_the_wyrm")
	to_chat(owner, span_warning("The Wyrm's corruption ceases spilling forth from your gaze, allowing you to fight once again."))
