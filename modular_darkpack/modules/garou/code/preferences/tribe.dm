/datum/preference/choiced/garou_tribe
	savefile_key = "garou_tribe"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Tribe"
	relevant_inherent_trait = TRAIT_WW_GAROU_TRIBE
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/garou_tribe/init_possible_values()
	return assoc_to_keys(GLOB.garou_tribes)

/datum/preference/choiced/garou_tribe/icon_for(value)
	var/datum/universal_icon/tribe_icon = uni_icon('icons/effects/effects.dmi', "nothing")
	//tribe_icon.blend_icon(uni_icon('modular_darkpack/modules/garou/icons/tribes.dmi', LOWER_TEXT(value)), ICON_OVERLAY)
	return tribe_icon

/datum/preference/choiced/garou_tribe/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features[FEATURE_GAROU_AUSPICE] = value
