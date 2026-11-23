#warn i could prob rework triggers of this into something more generic. ai_controller.react() or something that lets it pull from social roles on the human ai. idk.
/mob/living/proc/realistic_say(message, stop_moving = TRUE)
	if(stop_moving)
		GLOB.move_manager.stop_looping(src)

	if(!message)
		return FALSE
	if(stat >= HARD_CRIT)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_THINKING_IN_CHARACTER))
		return FALSE

	addtimer(CALLBACK(src, PROC_REF(start_talking), message), 1 SECONDS)
	return TRUE

/mob/living/proc/start_talking(message)
	ADD_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
	create_typing_indicator()
	var/typing_delay = round(length_char(message) * 0.5)
	addtimer(CALLBACK(src, PROC_REF(finish_talking), message), max(3 SECONDS, typing_delay))

/mob/living/proc/finish_talking(message)
	remove_typing_indicator()
	REMOVE_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
	say(message, forced = "AI Controller")
