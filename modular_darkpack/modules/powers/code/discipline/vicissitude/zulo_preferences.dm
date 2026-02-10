/datum/preference/choiced/zulo_form
	savefile_key = "zulo_form"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_REQUIRES_CLAN
	main_feature_name = "Zulo Form"
	relevant_inherent_trait = TRAIT_VICISSITUDE_KNOWLEDGE
	must_have_relevant_trait = TRUE
	should_generate_icons = TRUE

/datum/preference/choiced/zulo_form/init_possible_values()
	return assoc_to_keys(GLOB.zulo_form_list)

/datum/preference/choiced/zulo_form/icon_for(value)
	return uni_icon('modular_darkpack/modules/powers/icons/zulo_forms.dmi', get_zulo_form(value).id)

/datum/preference/choiced/zulo_form/apply_to_human(mob/living/carbon/human/target, value)
	return
