/mob/living/carbon/human/death(gibbed)
	. = ..()
	if(!.)
		return .

	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_MURDER, get_turf(src))
	GLOB.masquerade_breakers_list -= src
	GLOB.sabbatites -= src

