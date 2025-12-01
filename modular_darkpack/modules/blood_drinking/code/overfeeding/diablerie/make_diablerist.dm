
/mob/living/carbon/human/proc/make_diablerist()
	if(!client?.prefs)
		return

	if(!GLOB.canon_event)
		to_chat(src, span_warning("Cannot save diablerie preference; current round is not canon."))
	else
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/toggle/diablerist], TRUE)
	ADD_TRAIT(src, TRAIT_DIABLERIE, TRAIT_DIABLERIE)
	SEND_SIGNAL(src, COMSIG_MOB_UPDATE_AURA)
