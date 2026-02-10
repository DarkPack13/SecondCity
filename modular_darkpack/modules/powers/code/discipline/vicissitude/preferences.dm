/datum/preference/choiced/vampire_clan
	savefile_key = "vampire_clan"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Clan"
	relevant_inherent_trait = TRAIT_VICISSITUDE_KNOWLEDGE
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/vampire_clan/init_possible_values()
	return assoc_to_keys()

/datum/preference/choiced/vampire_clan/icon_for(value)
	return uni_icon('modular_darkpack/modules/vampire_the_masquerade/icons/vampire_clans.dmi', )

/datum/preference/choiced/vampire_clan/apply_to_human(mob/living/carbon/human/target, value)
	target.set_clan(value, TRUE)
