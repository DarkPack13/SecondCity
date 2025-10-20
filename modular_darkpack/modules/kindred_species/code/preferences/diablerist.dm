/datum/preference/toggle/diablerist
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "diablerist"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_TABLETOP
	relevant_inherent_trait = TRAIT_DRINKS_BLOOD
	default_value = FALSE

/datum/preference/toggle/diablerist/apply_to_human(mob/living/carbon/human/target, value)
	if(value)
		ADD_TRAIT(target, TRAIT_DIABLERIE, TRAIT_DIABLERIE)

