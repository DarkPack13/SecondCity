/datum/preference/choiced/garou_breed
	savefile_key = "garou_breed"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Breed"
	relevant_inherent_trait = TRAIT_VTM_GAROU_BREEDS
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/vampire_clan/init_possible_values()
	return assoc_to_keys(list(BREED_HOMID, BREED_LUPUS, BREED_CRINOS))

/datum/preference/choiced/vampire_clan/icon_for(value)
	return uni_icon('modular_darkpack/modules/deprecated/icons/ui_icons/vampire_clans.dmi', )

/datum/preference/choiced/vampire_clan/apply_to_human(mob/living/carbon/human/target, value)
	target.garou_breed = value
