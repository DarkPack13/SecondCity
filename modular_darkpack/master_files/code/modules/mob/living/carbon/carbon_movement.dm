/mob/living/carbon/Move(atom/newloc, direct, glide_size_override)
	if (ishuman(src))
		var/mob/living/carbon/human/H = src
		H.update_shadow()

	// DARKPACK TODO - reimplement walls, also this handling could be improved
	/*
	if (HAS_TRAIT(src, TRAIT_RUBICON))
		if(istype(NewLoc, /turf/open/water/vamp_sewer))
			return
	*/

	. = ..()

	// DARKPACK TODO - face target
	/*
	if(combat_mode && client)
		setDir(harm_focus)
	else
		harm_focus = dir
	*/
