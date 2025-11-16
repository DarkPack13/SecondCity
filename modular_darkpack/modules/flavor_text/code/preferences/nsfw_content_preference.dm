/datum/preference/toggle/nsfw_content_pref
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "nsfw_content_pref"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE

/datum/preference/toggle/nsfw_content_pref/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE

	if(CONFIG_GET(flag/nsfw_content))
		return TRUE

	return FALSE
