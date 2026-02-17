/datum/preference/numeric/height
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "height"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	minimum = HUMAN_HEIGHT_DWARF    // 6 would be like. 4'10
	maximum = HUMAN_HEIGHT_TALLEST  // 18 would be like... 6'8 or 6'10?

/datum/preference/numeric/height/create_default_value()
	return HUMAN_HEIGHT_MEDIUM  // 12 or 5'10 or 5'11 idk

/datum/preference/numeric/height/apply_to_human(mob/living/carbon/human/target, value)
	target.set_mob_height(value)

