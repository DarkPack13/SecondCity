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
	savefile_key = RENOWN_HONOR

/datum/preference/numeric/renown/honor/apply_to_human(mob/living/carbon/human/target, value)
	target.honor = value


/datum/preference/numeric/renown/glory
	savefile_key = RENOWN_GLORY

/datum/preference/numeric/renown/glory/apply_to_human(mob/living/carbon/human/target, value)
	target.glory = value


/datum/preference/numeric/renown/wisdom
	savefile_key = RENOWN_WISDOM

/datum/preference/numeric/renown/wisdom/apply_to_human(mob/living/carbon/human/target, value)
	target.wisdom = value
*/
/*
/datum/preference/numeric/fera_rank
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED // DARKPACK TODO - Render this somewhere
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = 0
	maximum = 5
*/
