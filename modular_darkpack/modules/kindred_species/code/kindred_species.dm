/**
 * This is the splat (supernatural type, game line in the World of Darkness) container
 * for all vampire-related code. I think this is stupid and I don't want any of this to
 * be the way it is, but if we're going to work with the code that's been written then
 * my advice is to centralise all stuff directly relating to vampires to here if it isn't
 * already in another organisational structure.
 *
 * The same applies to other splats, like /datum/species/garou or /datum/species/ghoul.
 * Halfsplats like ghouls are going to share some code with their fullsplats (vampires).
 * I dunno what to do about this except a reorganisation to make this stuff actually good.
 * The plan right now is to create a /datum/splat parent type and then have everything branch
 * from there, but that's for the future.
 */

/datum/species/human/kindred
	name = "Kindred"
	plural_form = "Kindred"
	id = SPECIES_KINDRED
	examine_limb_id = SPECIES_HUMAN
	// Character creation buttons will not display if these traits aren't here
	inherent_traits = list(
		TRAIT_VTM_MORALITY,
		TRAIT_VTM_CLANS,
		TRAIT_UNAGING,
	)
	changesource_flags = MIRROR_BADMIN
	var/datum/vampire_clan/clan
	var/enlightenment
	COOLDOWN_DECLARE(torpor_timer)

/mob/living/carbon/human/species/kindred
	race = /datum/species/human/kindred

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
