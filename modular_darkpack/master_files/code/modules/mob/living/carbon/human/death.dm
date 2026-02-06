/mob/living/carbon/human/death(gibbed)
	. = ..()

	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_MURDER, get_turf(src))
	GLOB.masquerade_breakers_list -= src
	GLOB.sabbatites -= src


	if(!iskindred(src))
		return
	can_be_embraced = FALSE
	var/obj/item/organ/brain/brain = get_organ_slot(ORGAN_SLOT_BRAIN) //NO REVIVAL EVER
	if(brain)
		brain.organ_flags |= ORGAN_FAILING

	/*
	if(HAS_TRAIT(src, TRAIT_IN_FRENZY))
		exit_frenzymod()
	*/
	SEND_SOUND(src, sound('modular_darkpack/modules/vampire_the_masquerade/sounds/final_death.ogg', 0, 0, 50))

	switch (chronological_age)
		if(-INFINITY to 10) //normal corpse
			return
		if(10 to 50)
			rot_body(1) //skin takes on a weird colouration
			visible_message(span_notice("[src]'s skin loses some of its colour."))
		if(50 to 100)
			rot_body(2) //looks slightly decayed
			visible_message(span_notice("[src]'s skin rapidly decays."))
		if(100 to 150)
			rot_body(3) //looks very decayed
			visible_message(span_warning("[src]'s body rapidly decomposes!"))
		if(150 to 200)
			rot_body(4) //mummified skeletonised corpse
			visible_message(span_warning("[src]'s body rapidly skeletonises!"))
		if(200 to INFINITY) //turn to ash
			playsound(src, 'modular_darkpack/modules/vampire_the_masquerade/sounds/burning_death.ogg', 80, TRUE)
			dust(just_ash = TRUE, drop_items = TRUE, force = TRUE)
