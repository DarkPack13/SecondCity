/datum/species/human/kindred
	name = "Kindred"
	plural_form = "Kindred"
	id = SPECIES_KINDRED
	examine_limb_id = SPECIES_HUMAN
	// Character creation buttons will not display if these traits aren't here
	inherent_traits = list(
		TRAIT_USES_SKINTONES,
		TRAIT_VTM_MORALITY,
		TRAIT_VTM_CLANS,
		TRAIT_UNAGING,
	)
	changesource_flags = MIRROR_BADMIN

/mob/living/carbon/human/species/kindred
	race = /datum/species/human/kindred

/datum/species/human/kindred/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons, replace_missing)
	. = ..()

	human_who_gained_species.make_kindred()

/datum/species/human/kindred/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()

	human.remove_splat(/datum/splat/vampire/kindred)

/datum/species/human/kindred/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#333333", update = FALSE)
	human.set_hairstyle("Undercut Left", update = TRUE)
	human.set_eye_color("#ff0000")
	human.undershirt = "T-Shirt (Red)"
	human.update_body()
	human.equipOutfit(/datum/outfit/job/vampire/prince, TRUE)

/datum/species/human/kindred/get_species_description()
	return "Blood sucking vampires of the dark realm!"

/datum/species/human/kindred/get_species_lore()
	return list(
		"Insert Kindred Lore Here",
	)

/datum/species/human/kindred/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "book-dead",
			SPECIES_PERK_NAME = "Kindred Clans",
			SPECIES_PERK_DESC = "Kindred belong to many clans, which you are able to choose in the preferences, all with their own special abilities and weaknesses!",
		),
	)

	return to_add

// Vampire blood is special, so it needs to be handled with its own entry.
/datum/species/human/kindred/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Example Negative Perk",
		SPECIES_PERK_DESC = "Lorem Ipsum",
	))

	return to_add

// There isn't a "Minor Undead" biotype, so we have to explain it in an override (see: dullahans)
/datum/species/human/kindred/create_pref_biotypes_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "skull",
		SPECIES_PERK_NAME = "Minor Undead",
		SPECIES_PERK_DESC = "[name] are minor undead. \
			Minor undead enjoy some of the perks of being dead, like \
			not needing to breathe or eat, but do not get many of the \
			environmental immunities involved with being fully undead.",
	))

	return to_add
