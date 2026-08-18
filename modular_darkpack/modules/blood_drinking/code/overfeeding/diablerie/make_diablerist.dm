
/mob/living/carbon/human/proc/make_diablerist()
	write_preference_midround(/datum/preference/toggle/diablerist, TRUE)
	ADD_TRAIT(src, TRAIT_DIABLERIE, TRAIT_DIABLERIE)
	SEND_SIGNAL(src, COMSIG_MOB_UPDATE_AURA)
