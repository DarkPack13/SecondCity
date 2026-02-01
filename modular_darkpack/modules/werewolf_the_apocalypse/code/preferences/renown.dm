/datum/preference/numeric/renown
	abstract_type = /datum/preference/numeric/renown
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED // DARKPACK TODO - Render this somewhere
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = 1
	maximum = 10

/datum/preference/numeric/renown/create_default_value()
	return 1

/*
/datum/preference/numeric/renown/honor
	savefile_key = "honor"

/datum/preference/numeric/renown/honor/apply_to_human(mob/living/carbon/human/target, value)
	target.honor = value


/datum/preference/numeric/renown/glory
	savefile_key = "glory"

/datum/preference/numeric/renown/glory/apply_to_human(mob/living/carbon/human/target, value)
	target.glory = value


/datum/preference/numeric/renown/wisdom
	savefile_key = "wisdom"

/datum/preference/numeric/renown/wisdom/apply_to_human(mob/living/carbon/human/target, value)
	target.wisdom = value
*/
