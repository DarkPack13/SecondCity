/datum/preference/numeric/masquerade
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED // TODO: [Rebase] - Render this somewhere
	savefile_key = "masquerade"
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = 1
	maximum = 5

/datum/preference/numeric/masquerade/create_default_value()
	return 5

/datum/preference/numeric/masquerade/apply_to_human(mob/living/carbon/human/target, value)
	target.masquerade_score = value
