#define STAGE_GRAB_VICTIM "STAGE_GRAB_VICTIM"
#define STAGE_PRESS_BITE "STAGE_PRESS_BITE"
#define STAGE_RELEASE_VICTIM "STAGE_RELEASE_VICTIM"

/// Tutorial for showing how to switch hands.
/// Fired when clicking on an item with another item with an empty inactive hand.
/datum/tutorial/bite_prey
	// grandfather_date = "2023-01-07"

	var/stage = STAGE_GRAB_VICTIM

/datum/tutorial/bite_prey/Destroy(force)
	return ..()

/datum/tutorial/bite_prey/perform(list/modifiers)
	addtimer(CALLBACK(src, PROC_REF(show_instructions)), 0.5 SECONDS)

	RegisterSignal(user, COMSIG_MOVABLE_SET_GRAB_STATE, PROC_REF(on_grab))
	RegisterSignal(user, COMSIG_MOB_VAMPIRE_SUCKING, PROC_REF(on_bite))
	RegisterSignal(user, COMSIG_ATOM_NO_LONGER_PULLING, PROC_REF(on_release))

/datum/tutorial/bite_prey/perform_completion_effects_with_delay()
	UnregisterSignal(user, list(COMSIG_MOVABLE_SET_GRAB_STATE, COMSIG_MOB_VAMPIRE_SUCKING, COMSIG_ATOM_NO_LONGER_PULLING))
	return 0

/datum/tutorial/bite_prey/proc/show_instructions()
	if(QDELETED(src))
		return

	switch(stage)
		if(STAGE_GRAB_VICTIM)
			show_instruction("Pull then grab the NPC to regain BP.")
		if(STAGE_PRESS_BITE)
			show_instruction(keybinding_message(
				/datum/keybinding/human/bite,
				"Press '%KEY%' to bite",
				"Set a key to bite",
			))
		if(STAGE_RELEASE_VICTIM)
			show_instruction(keybinding_message(
				/datum/keybinding/mob/stop_pulling,
				"Press '%KEY%' to release to stop feeding!.",
				"Click '<b>Pull</b>' to stop feeding!.",
			))

/datum/tutorial/bite_prey/proc/on_grab(mob/living/source, newstate)
	SIGNAL_HANDLER

	if((newstate >= GRAB_AGGRESSIVE) && isnpc(source.pulling))
		stage = STAGE_PRESS_BITE
		show_instructions()
	/*
	else if(stage == STAGE_PRESS_BITE)
		stage = STAGE_GRAB_VICTIM
		show_instructions()
	*/

/datum/tutorial/bite_prey/proc/on_bite(mob/living/carbon/human/drinker, mob/drunk_from)
	SIGNAL_HANDLER

	stage = STAGE_RELEASE_VICTIM
	show_instructions()

/datum/tutorial/bite_prey/proc/on_release()
	SIGNAL_HANDLER

	if(stage == STAGE_PRESS_BITE)
		stage = STAGE_GRAB_VICTIM
		show_instructions()
	else if(stage == STAGE_RELEASE_VICTIM)
		complete()

#undef STAGE_RELEASE_VICTIM
#undef STAGE_PRESS_BITE
#undef STAGE_GRAB_VICTIM
