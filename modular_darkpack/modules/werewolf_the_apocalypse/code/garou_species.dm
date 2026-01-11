/datum/species/human/shifter/garou
	name = "Garou"
	plural_form = "Garou"
	id = SPECIES_GAROU
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_USES_SKINTONES,
		TRAIT_WTA_GAROU_BREED,
		TRAIT_WTA_GAROU_AUSPICE,
		TRAIT_WTA_GAROU_TRIBE,
	)
	changesource_flags = MIRROR_BADMIN
	species_language_holder = /datum/language_holder/garou
	mutanttongue = /obj/item/organ/tongue/garou

/datum/species/human/shifter/garou/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons, replace_missing)
	. = ..()
	human_who_gained_species.add_splat(/datum/splat/werewolf/shifter/garou)

/datum/species/human/shifter/garou/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	human.remove_splat(/datum/splat/werewolf/shifter/garou)

/datum/species/human/shifter/garou/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#502D15", update = FALSE)
	human.set_hairstyle("Long Hair 3", update = TRUE)
	human.undershirt = "Shirt (Alien)"
	human.update_body()

/datum/species/human/shifter/garou/randomize_features()
	var/list/features = ..()
	features[FEATURE_FERA_BREED] = pick(GLOB.garou_breeds)
	return features

/datum/species/human/shifter/garou/get_species_description()
	return "Lorem Ipsum"

/datum/species/human/shifter/garou/get_species_lore()
	return list(
		"Lorem Ipsum",
	)

/datum/species/human/shifter/garou/create_pref_unique_perks()
	var/list/to_add = list()

	/*
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "shield",
		SPECIES_PERK_NAME = "Garou",
		SPECIES_PERK_DESC = "Its a Garou.",
	))
	*/

	return to_add

/mob/living/carbon/human/species/garou
	race = /datum/species/human/shifter/garou
