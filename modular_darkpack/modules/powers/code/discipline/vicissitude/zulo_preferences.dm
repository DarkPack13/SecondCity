/datum/preference/choiced/zulo_form
	savefile_key = "zulo_form"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_REQUIRES_CLAN
	main_feature_name = "Zulo Form"
	relevant_inherent_trait = TRAIT_VICISSITUDE_KNOWLEDGE
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/zulo_form/has_relevant_feature(datum/preferences/preferences)
	return TRUE

/datum/preference/choiced/zulo_form/init_possible_values()
	return list("fiend", "leviathan", "shrikebush", "impalersteed", "black_fiend", "doctor", "dog", "emily", "dragon", "tendrildragon") // Maybe this being a define would be better.

/datum/preference/choiced/zulo_form/icon_for(value)
	return uni_icon('modular_darkpack/modules/powers/icons/zulo_forms.dmi', value)

/datum/preference/choiced/zulo_form/create_default_value()
	return "fiend"

/datum/preference/choiced/zulo_form/apply_to_human(mob/living/carbon/human/target, value)
	return
