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
	for(var/datum/st_stat/stat in GLOB.storyteller_stats)
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
	return data

/datum/preference_middleware/stats/proc/increase_stat(list/params, mob/user)
	var/stat_path = text2path(params["stat"])



	var/new_value = preferences.storyteller_stats[stat_path]
	var/log_text = "[key_name(user, TRUE, TRUE)] increased stat '[public_stat.name]' from [old_value] to [new_value]"
	log_stats(log_text)
	return TRUE

/datum/preference_middleware/stats/proc/decrease_stat(list/params, mob/user)
	var/stat_path = text2path(params["stat"])



	var/new_value = preferences.storyteller_stats[stat_path]
	var/log_text = "[key_name(user, TRUE, TRUE)] decreased stat '[preferences.st_stats.name]' from [old_value] to [new_value]"
	log_stats(log_text)
	return TRUE

/datum/preference_middleware/stats/proc/reset_stats(list/params, mob/user)
	var/log_text = "[key_name(user, TRUE, TRUE)] reset all stats to default values"
	log_stats(log_text)

	storyteller_stats = null
	for(var/datum/st_stat/path as anything in valid_subtypesof(/datum/st_stat))
		var/datum/st_stat/new_trait = new path
		storyteller_stats[path] = new_trait
	preferences.storyteller_stats = new_stats
	return TRUE
