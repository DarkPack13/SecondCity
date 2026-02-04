/*
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
	mutanttongue = /obj/item/organ/tongue/fera

/mob/living/carbon/human/species/garou
	race = /datum/species/human/shifter/garou

/datum/species/human/shifter/garou/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons, replace_missing)
	. = ..()
	human_who_gained_species.add_splat(/datum/splat/werewolf/shifter/garou)

/datum/species/human/shifter/garou/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	human.remove_splat(/datum/splat/werewolf/shifter/garou)

/datum/species/human/shifter/garou/randomize_features()
	var/list/features = ..()
	features[FEATURE_FERA_BREED] = pick(GLOB.breed_forms_list)
	return features
*/

