/// Given a human, will adjust it before taking a picture for the preferences UI.
/// This should create a CONSISTENT result, so the icons don't randomly change.
/datum/splat/proc/prepare_human_for_preview(mob/living/carbon/human/human)
	return

#warn make stacktrace
/datum/splat/proc/get_splats_description()
	return "No splat description set, file a bug report!"

/datum/splat/proc/get_splats_lore()
	return list("No splat lore set, file a bug report!")


/**
 * Used to add any splat specific perks to the perk list.
 *
 * Returns null by default. When overriding, return a list of perks.
 */
/datum/splat/proc/create_pref_unique_perks()
	return null

/**
 * Generates a list of "perks" related to this splat
 * (Postives, neutrals, and negatives)
 * in the format of a list of lists.
 * Used in the preference menu.
 *
 * "Perk" format is as followed:
 * list(
 *   SPECIES_PERK_TYPE = type of perk (postiive, negative, neutral - use the defines)
 *   SPECIES_PERK_ICON = icon shown within the UI
 *   SPECIES_PERK_NAME = name of the perk on hover
 *   SPECIES_PERK_DESC = description of the perk on hover
 * )
 *
 * Returns a list of lists.
 * The outer list is an assoc list of [perk type]s to a list of perks.
 * The innter list is a list of perks. Can be empty, but won't be null.
 */
/datum/splat/proc/get_splats_perks()
	var/list/splat_perks = list()

	// Let us get every perk we can conceive of in one big list.
	// The order these are called (kind of) matters.
	// Species unique perks first, as they're more important than genetic perks,
	// and language perk last, as it comes at the end of the perks list
	splat_perks += create_pref_unique_perks()
	// splat_perks += create_pref_blood_perks()
	// splat_perks += create_pref_damage_perks()
	// splat_perks += create_pref_temperature_perks()
	// splat_perks += create_pref_traits_perks()
	// splat_perks += create_pref_biotypes_perks()
	// splat_perks += create_pref_organs_perks()
	// splat_perks += create_pref_language_perk()

	// Some overrides may return `null`, prevent those from jamming up the list.
	list_clear_nulls(splat_perks)

	// Now let's sort them out for cleanliness and sanity
	var/list/perks_to_return = list(
		SPECIES_POSITIVE_PERK = list(),
		SPECIES_NEUTRAL_PERK = list(),
		SPECIES_NEGATIVE_PERK = list(),
	)

	for(var/list/perk as anything in splat_perks)
		var/perk_type = perk[SPECIES_PERK_TYPE]
		// If we find a perk that isn't postiive, negative, or neutral,
		// it's a bad entry - don't add it to our list. Throw a stack trace and skip it instead.
		if(isnull(perks_to_return[perk_type]))
			stack_trace("Invalid splat perk ([perk[SPECIES_PERK_NAME]]) found for splat [name]. \
				The type should be positive, negative, or neutral. (Got: [perk_type])")
			continue

		perks_to_return[perk_type] += list(perk)

	return perks_to_return
