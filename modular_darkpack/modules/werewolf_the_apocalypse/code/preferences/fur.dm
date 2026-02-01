/datum/preference/choiced/garou_fur_color
	savefile_key = "garou_fur_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Fera Fur Color"
	relevant_inherent_trait = TRAIT_FERA_FUR
	must_have_relevant_trait = TRUE

/datum/preference/choiced/garou_fur_color/init_possible_values()
	return assoc_to_keys(GLOB.garou_fur_colors)


/datum/preference/choiced/garou_fur_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features[FEATURE_FUR_COLOR] = value
