/mob/living/carbon/human/death(gibbed)
	. = ..()

	if(iskindred(src))
		SSmasquerade.dead_level = min(1000, SSmasquerade.dead_level+50)
	else
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.zone_type == ZONE_MASQUERADE)
				SSmasquerade.dead_level = max(0, SSmasquerade.dead_level-25)
	var/witness_count
	for(var/mob/living/carbon/human/npc/NEPIC in viewers(7, usr))
		if(NEPIC && NEPIC.stat != DEAD)
			witness_count++
		if(witness_count > 1)
			for(var/obj/item/police_radio/radio in GLOB.police_radios)
				radio.announce_crime("murder", get_turf(src))
			for(var/obj/machinery/p25transceiver/police/radio in GLOB.p25_transceivers)
				if(radio.p25_network == "police")
					radio.announce_crime("murder", get_turf(src))
					break
	GLOB.masquerade_breakers_list -= src
	GLOB.sabbatites -= src


	if(iskindred(src))
		can_be_embraced = FALSE
		var/obj/item/organ/brain/brain = getorganslot(ORGAN_SLOT_BRAIN) //NO REVIVAL EVER
		if (brain)
			brain.organ_flags |= ORGAN_FAILING

		if(in_frenzy)
			exit_frenzymod()
		SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/final_death.ogg', 0, 0, 50))

		var/years_undead = chronological_age - age
		switch (years_undead)
			if (-INFINITY to 10) //normal corpse
				return
			if (10 to 50)
				rot_body(1) //skin takes on a weird colouration
				visible_message(span_notice("[src]'s skin loses some of its colour."))
			if (50 to 100)
				rot_body(2) //looks slightly decayed
				visible_message(span_notice("[src]'s skin rapidly decays."))
			if (100 to 150)
				rot_body(3) //looks very decayed
				visible_message(span_warning("[src]'s body rapidly decomposes!"))
			if (150 to 200)
				rot_body(4) //mummified skeletonised corpse
				visible_message(span_warning("[src]'s body rapidly skeletonises!"))
			if (200 to INFINITY) //turn to ash
				playsound(src, 'modular_darkpack/modules/deprecated/sounds/burning_death.ogg', 80, TRUE)
				lying_fix()
				dir = SOUTH
				INVOKE_ASYNC(src, TYPE_PROC_REF(/mob/living/carbon/human, dust), TRUE, TRUE)
