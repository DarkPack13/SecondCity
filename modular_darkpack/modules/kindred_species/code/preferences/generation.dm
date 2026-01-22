/datum/preference/numeric/generation
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "generation"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	//relevant_inherent_trait = TRAIT_DRINKS_BLOOD
	minimum = MAX_PUBLIC_GENERATION
	maximum = HIGHEST_GENERATION_LIMIT

/datum/preference/numeric/generation/apply_to_human(mob/living/carbon/human/target, value)
	iskindred(target)?.set_generation(value)

/datum/preference/numeric/generation/is_accessible(datum/preferences/preferences)
	if(!..())
		return FALSE

	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	return ispath(species_type, /datum/species/human/kindred)
