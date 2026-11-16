/datum/preference_middleware/triatic_taint

/datum/preference_middleware/triatic_taint/get_ui_data(mob/user)
	if(preferences.current_window != PREFERENCE_TAB_CHARACTER_PREFERENCES)
		return list()
	var/list/data = list()
	data["taints"] = list(TRIAT_WYRM = 0, TRIAT_WEAVER = 0, TRIAT_WYLD = 0)

	return data
