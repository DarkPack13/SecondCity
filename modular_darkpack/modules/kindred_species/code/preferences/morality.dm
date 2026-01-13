/datum/preference/choiced/vtm_morality
	savefile_key = "morality_path"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_TABLETOP
	main_feature_name = "Path"
	relevant_inherent_trait = TRAIT_VTM_MORALITY
	must_have_relevant_trait = TRUE
	can_randomize = FALSE

/datum/preference/choiced/vtm_morality/create_default_value()
	return "Humanity"

/datum/preference/choiced/vtm_morality/init_possible_values()
	return list("Humanity", "Enlightenment")

/datum/preference/choiced/vtm_morality/apply_to_human(mob/living/carbon/human/target, value)
	if (value != "Enlightenment")
		return

	iskindred(target)?.enlightenment = TRUE
