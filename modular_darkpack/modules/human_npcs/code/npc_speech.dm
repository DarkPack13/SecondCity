#warn i could prob rework triggers of this into something more generic. ai_controller.react() or something that lets it pull from social roles on the human ai. idk.
/mob/living/proc/realistic_say(message, stop_moving = TRUE, source = CURRENTLY_TYPING_TRAIT, should_sleep = FALSE)
	if(stop_moving)
		GLOB.move_manager.stop_looping(src)

	if(!message)
		return FALSE
	if(stat >= HARD_CRIT)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_THINKING_IN_CHARACTER))
		return FALSE

	start_talking(message, source)
	return TRUE

/mob/living/proc/start_talking(message, source, should_sleep = FALSE)
	ADD_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, source)
	create_typing_indicator()
	var/typing_delay = max(3 SECONDS, round(length_char(message) * 0.5))

	if(should_sleep) // If we ACCTALLY want this to be blocking (cause they are typing c:)
		sleep(typing_delay)
		finish_talking(message, source)
	else
		addtimer(CALLBACK(src, PROC_REF(finish_talking), message, source), typing_delay)

/mob/living/proc/finish_talking(message, source)
	remove_typing_indicator()
	REMOVE_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, source)
	say(message, forced = "AI Controller")
