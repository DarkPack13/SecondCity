
/mob/living/carbon/human/proc/make_diablerist()
	if(!client?.prefs)
		return

	client.prefs.write_preference_midround(GLOB.preference_entries[/datum/preference/toggle/diablerist], TRUE)
	ADD_TRAIT(src, TRAIT_DIABLERIE, TRAIT_DIABLERIE)
	SEND_SIGNAL(src, COMSIG_MOB_UPDATE_AURA)
