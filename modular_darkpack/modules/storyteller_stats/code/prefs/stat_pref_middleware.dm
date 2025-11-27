/datum/preference_middleware/stats
	action_delegations = list(
		"increase_stat" = PROC_REF(increase_stat),
		"decrease_stat" = PROC_REF(decrease_stat),
		"reset_stats" = PROC_REF(reset_stats)
	)

/datum/preference_middleware/stats/get_ui_static_data(mob/user)
	if (preferences.current_window != PREFERENCE_TAB_CHARACTER_PREFERENCES)
		return list()

	var/list/data = list()
	data["static_stats"] = list()
	for(var/stat_type in GLOB.storyteller_stats)
		var/datum/st_stat/stat = GLOB.storyteller_stats[stat_type]
		var/list/stat_data = list()
		stat_data["name"] = stat.name
		stat_data["desc"] = stat.description
		stat_data["editable"] = stat.editable
		stat_data["category"] = stat.category
		stat_data["subcategory"] = stat.subcategory
		stat_data["max_score"] = stat.max_score
		data["static_stats"][stat_type] = stat_data
	return data

/datum/preference_middleware/stats/get_ui_data(mob/user)
	var/list/data = list()
	data["stats"] = preferences.storyteller_stats
	data["points"] = preferences.storyteller_stat_points
	return data

/datum/preference_middleware/stats/proc/increase_stat(list/params, mob/user)
	var/stat_path = text2path(params["stat"])
	var/datum/st_stat/public_stat = GLOB.storyteller_stats[stat_path]
	if(!public_stat)
		return FALSE

	return TRUE

/datum/preference_middleware/stats/proc/decrease_stat(list/params, mob/user)
	var/stat_path = text2path(params["stat"])
	var/datum/st_stat/public_stat = GLOB.storyteller_stats[stat_path]
	if(!public_stat)
		return FALSE

	return TRUE

/datum/preference_middleware/stats/proc/reset_stats(list/params, mob/user)
	preferences.storyteller_stats = SSstats.sanitize_stat_list()
	preferences.storyteller_stat_points = SSstats.sanitize_points_list()
	return TRUE
