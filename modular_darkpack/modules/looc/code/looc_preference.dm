/datum/preference/toggle/see_looc
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE
	savefile_key = "looc_admin_pref"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/see_looc/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE

	return is_admin(preferences.parent)
