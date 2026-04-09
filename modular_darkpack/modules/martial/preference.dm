/datum/preference/choiced/martial_art
	savefile_key = "martial_art"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Martial Art"
	relevant_inherent_trait = TRAIT_TRAINED_BRAWLER
	must_have_relevant_trait = TRUE

/datum/preference/choiced/martial_art/init_possible_values()
	return assoc_to_keys(GLOB.allowed_martial_arts)

/datum/preference/choiced/martial_art/apply_to_human(mob/living/carbon/human/target, value)
	if(!value)
		return
	var/datum/martial_art/MA = new value(target)
	MA.teach(target)
