/mob/living/carbon/human/proc/adjust_masquerade(value, forced)
	if (!iskindred(src) && !isghoul(src) && !iscathayan(src))
		return
	var/datum/species/human/kindred/vampirism = dna.species

	if (!forced)
		if (value > 0)
			if (HAS_TRAIT(src, TRAIT_VIOLATOR))
				return
		if (istype(get_area(src), /area/vtm))
			var/area/vtm/current_area = get_area(src)
			if (current_area.zone_type != ZONE_MASQUERADE)
				return
		if (!COOLDOWN_FINISHED(src, masquerade_violation_cooldown))
			return

	COOLDOWN_START(src, masquerade_violation_cooldown, 10 SECONDS)

	if (value < 0)
		if (masquerade <= 0)
			return

		SEND_SOUND(src, sound('sound/wod13/masquerade_violation.ogg', 0, 0, 75))
		to_chat(src, span_userdanger("<b>MASQUERADE VIOLATION!</b>"))
	else if (value > 0)
		if (vampirism.enlightenment)
			AdjustHumanity(1, 10)

		for (var/mob/living/carbon/human/H in GLOB.player_list)
			H.voted_for -= dna.real_name

		if (masquerade >= 5)
			return

		SEND_SOUND(src, sound('sound/wod13/general_good.ogg', 0, 0, 75))
		to_chat(src, span_boldnicegreen("<b>MASQUERADE REINFORCED!</b>"))

	masquerade = clamp(masquerade + value, 0, 5)

	if (src in GLOB.masquerade_breakers_list)
		if (masquerade > 2)
			GLOB.masquerade_breakers_list -= src
	else if (masquerade < 3)
		GLOB.masquerade_breakers_list |= src
