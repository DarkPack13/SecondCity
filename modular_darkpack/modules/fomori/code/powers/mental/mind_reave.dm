/datum/storyteller_roll/mind_reave
	bumper_text = "mind reave"
	difficulty = 6
	applicable_stats = list(STAT_INTELLIGENCE, STAT_INTIMIDATION)
	numerical = TRUE
	roll_output_type = ROLL_PRIVATE

/datum/storyteller_roll/mind_reave/defender
	bumper_text = "willpower"
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	numerical = FALSE
	roll_output_type = ROLL_NONE

/datum/action/cooldown/power/fomori_power/mind_reave
	name = "Mind Reave"
	desc = "Spend a willpower point to rest thoughts and memories from a victim's mind."
	button_icon_state = "mind_reave"
	rank = 1 // of 1
	click_to_activate = TRUE
	willpower_cost = 1

/datum/action/cooldown/power/fomori_power/mind_reave/Activate(atom/target)
	if(!isliving(target))
		return FALSE

	var/mob/living/victim = target

	. = ..()

	to_chat(owner, span_warning("You begin to probe into the mind of [victim]..."))

	if(!do_after(owner, 1 TURNS, victim))
		to_chat(owner, span_userdanger("...but you stop short of getting anything out of it."))

		StartCooldown()
		return TRUE

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/mind_reave
	var/ourpower = roll_datum.st_roll(owner)

	var/datum/storyteller_roll/defender_datum = new /datum/storyteller_roll/mind_reave/defender
	var/theirpower = defender_datum.st_roll(owner)


	if(ourpower > theirpower)
		to_chat(victim, span_userdanger("You feel your mind being ravaged by malignant energy!"))
		SEND_SOUND(victim, sound('sound/effects/magic/clockwork/invoke_general.ogg', volume = 50))

		var/successes = ourpower - theirpower
		var/demand_text

		switch(successes)
			if(1)
				demand_text = "surface level thoughts such as emotions or current thoughts"
			if(2)
				demand_text = "deep thoughts like recent memories or strong opinions"
			if(3 to INFINITY)
				demand_text = "your deepest and most instinctual thoughts, feelings, or secrets"

		var/composed_message = "The malignant energy probing your mind reaches for [demand_text]. What does it learn?"

		var/input_text = tgui_input_text(victim, composed_message, "Mind Reave", CHAT_MESSAGE_MAX_LENGTH, multiline = TRUE, timeout = 30 SECONDS)
		victim.Stun(30 SECONDS, TRUE)

		message_admins("[ADMIN_LOOKUPFLW(owner)] used [src] on [ADMIN_LOOKUPFLW(victim)] with [successes] successes.")

		if(input_text)
			message_admins("[ADMIN_LOOKUPFLW(victim)] responded to [ADMIN_LOOKUPFLW(owner)]'s Mind Reave: \"[input_text]\".")
			to_chat(owner, span_bolddanger("Your power wrests the following information from [victim]: \"[input_text]\""))
			to_chat(owner, span_bolddanger("Your feel your mind surrender the following information to [owner]: \"[input_text]\""))
			victim.SetStun(1 TURNS)
		else
			message_admins("[ADMIN_LOOKUPFLW(victim)] failed or declined to respond to [ADMIN_LOOKUPFLW(owner)]'s Mind Reave.")
			to_chat(owner, span_userdanger("[victim]'s mind buckles under the pressure of your mental energy!"))
			to_chat(victim, span_userdanger("Your mind buckles under the pressure of [owner]'s mental energy!"))
			victim.Sleeping(30 SECONDS)

	StartCooldown()
	return TRUE
#warn MIND REAVE NEEDS 2 CLIENT TESTING
