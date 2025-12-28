/**
 * Assigns a human an alternative body sprite
 * accounting for body model. If no sprite name
 * is supplied, sets it to the default for the
 * human depending on species or Clan.
 *
 * Arguments:
 * * sprite_name - Name of the sprite that'll be used as the base for this human's limbs.
 * * greyscale - If the new limbs use skin tone.
 */
/mob/living/carbon/human/proc/set_body_sprite(sprite_name, greyscale, ignore_clan)
	// Cannot be used without species code as this relies on examine_limbs_id for defaults
	CHECK_DNA_AND_SPECIES(src)

	// If no base sprite is supplied, get a default from either the species or the Clan
	if (!sprite_name)
		var/datum/vampire_clan/clan = get_clan()
		if (clan?.alt_sprite && !ignore_clan)
			sprite_name = clan.alt_sprite
			greyscale = clan.alt_sprite_greyscale
		else
			sprite_name = SPECIES_HUMAN
			greyscale = TRUE

	// Update all limbs to the new sprite and greyscale
	for (var/obj/item/bodypart/bodypart as anything in bodyparts)
		var/icon_to_set = greyscale ? DEFAULT_BODYPART_ICON_ORGANIC : bodypart.icon
		bodypart.change_appearance(icon_to_set, sprite_name, greyscale)

/**
 * Rots the vampire's body along four stages of decay.
 *
 * Vampire bodies are either pre-decayed if they're Cappadocians,
 * or they decay on death to what their body should naturally
 * be according to their chronological age. Stage 1 is
 * fairly normal looking with discoloured skin, stage 2 is
 * somewhat decayed-looking, stage 3 is very decayed, and stage
 * 4 is a long-dead completely decayed corpse. This has no effect
 * on Clans that already have alt_sprites unless they're being
 * rotted to stage 3 and above.
 *
 * Arguments:
 * * rot_stage - how much to rot the vampire, on a scale from 1 to 4.
 */
/mob/living/carbon/human/proc/rot_body(rot_stage)
	// Won't work unless this person has examine_limbs_id on species
	CHECK_DNA_AND_SPECIES(src)

	// Won't replace other alternative sprites unless it's advanced decay
	if (rot_stage <= 2)
		for (var/obj/item/bodypart/bodypart as anything in bodyparts)
			if (bodypart.limb_id == dna.species.examine_limb_id)
				continue
			if (findtext(bodypart.limb_id, "rotten"))
				if (text2num(copytext(bodypart.limb_id, 7)) < rot_stage)
					continue

			return

	// Apply rotten sprite and rotting effects
	switch (rot_stage)
		if (1)
			set_body_sprite("rotten1", TRUE)
		if (2)
			set_body_sprite("rotten2", TRUE)
		if (3)
			set_body_sprite("rotten3")
			set_hairstyle("Bald")
			set_facial_hairstyle("Shaved")
			ADD_TRAIT(src, TRAIT_MASQUERADE_VIOLATING_FACE, MAGIC_TRAIT)
		if (4)
			set_body_sprite("rotten4")
			set_hairstyle("Bald")
			set_facial_hairstyle("Shaved")
			ADD_TRAIT(src, TRAIT_MASQUERADE_VIOLATING_FACE, MAGIC_TRAIT)
