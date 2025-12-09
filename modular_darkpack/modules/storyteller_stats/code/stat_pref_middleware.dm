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
	for(var/stat_path as anything in GLOB.storyteller_stats)
		var/datum/st_stat/stat = new stat_path()
		var/list/stat_data = list()
		stat_data["name"] = stat.name
		stat_data["desc"] = stat.description
		stat_data["editable"] = stat.editable
		stat_data["category"] = stat.category
		stat_data["subcategory"] = stat.subcategory
		stat_data["max_score"] = stat.max_score
		data["static_stats"][stat_path] = stat_data
	return data

/datum/preference_middleware/stats/get_ui_data(mob/user)
	var/list/data = list()
	var/list/stats_list = list()
	for(var/stat_path as anything in preferences.preference_storyteller_stats)
		var/datum/st_stat/stat = new stat_path()
		stats_list += stat
	data["stats"] = stats_list
	return data

/datum/preference_middleware/stats/proc/increase_stat(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)

	var/datum/st_stat/stat_path = preferences.preference_storyteller_stats[text2path(params["stat"])]
	var/old_value = stat_path.get_score(FALSE)

	stat_path.increase_score(1)

	var/new_value = stat_path.get_score(FALSE)
	var/log_text = "[key_name(user, TRUE, TRUE)] increased stat '[stat_path.name]' from [old_value] to [new_value]"
	log_stats(log_text)
	return TRUE

/datum/preference_middleware/stats/proc/decrease_stat(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)

	var/datum/st_stat/stat_path = preferences.preference_storyteller_stats[text2path(params["stat"])]
	var/old_value = stat_path.get_score(FALSE)

	stat_path.decrease_score(1)

	var/new_value = stat_path.get_score(FALSE)
	var/log_text = "[key_name(user, TRUE, TRUE)] decreased stat '[stat_path.name]' from [old_value] to [new_value]"
	log_stats(log_text)
	return TRUE

/datum/preference_middleware/stats/proc/reset_stats(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)

	var/log_text = "[key_name(user, TRUE, TRUE)] reset all stats to default values"
	log_stats(log_text)
	preferences.preference_storyteller_stats = null

	var/list/stats_list = list()
	for(var/stat_path as anything in subtypesof(/datum/st_stat))
		var/datum/st_stat/stat = new stat_path()
		stat.set_score(stat.starting_score)
		stats_list[stat_path] = stat
	preferences.preference_storyteller_stats = stats_list
	return TRUE
