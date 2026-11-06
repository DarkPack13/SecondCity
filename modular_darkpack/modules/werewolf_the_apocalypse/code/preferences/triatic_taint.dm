/datum/preference/numeric/taint
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = null
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	minimum = 0
	maximum = 10
	can_randomize = FALSE
	step = 1

	abstract_type = /datum/preference/numeric/taint

	var/taint_type

/datum/preference/numeric/taint/create_default_value()
	return 0

/datum/preference/numeric/taint/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.adjust_specific_taint(taint_type, value)

/datum/preference/numeric/taint/wyrm
	savefile_key = "taint_wyrm"
	taint_type = TRIAT_WYRM

/datum/preference/numeric/taint/weaver
	savefile_key = "taint_weaver"
	taint_type = TRIAT_WEAVER

/datum/preference/numeric/taint/wyld
	savefile_key = "taint_wyld"
	taint_type = TRIAT_WYLD
