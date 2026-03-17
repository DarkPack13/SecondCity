/datum/preference/choiced/dice_output
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "dice_output"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/dice_output/init_possible_values()
	return list(DICE_OUTPUT_BALLOON, DICE_OUTPUT_CHAT)

/datum/preference/choiced/dice_output/create_default_value()
	return DICE_OUTPUT_CHAT
