/datum/preference_middleware/stats
	action_delegations = list(
		"increase_stat" = PROC_REF(increase_stat),
		"decrease_stat" = PROC_REF(decrease_stat)
	)

/datum/preference_middleware/stats/get_ui_static_data(mob/user)
	if (preferences.current_window != PREFERENCE_TAB_CHARACTER_PREFERENCES)
		return list()

	var/list/data = list()
	data["static_stats"] = list()
	for(var/stat_type in GLOB.public_storyteller_stats)
		var/datum/st_stat/stat = GLOB.public_storyteller_stats[stat_type]
		var/list/stat_data = list()
		stat_data["name"] = stat.name
		stat_data["desc"] = stat.description
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
	var/datum/st_stat/public_stat = GLOB.public_storyteller_stats[stat_path]
	if(!public_stat)
		return FALSE
	if(preferences.storyteller_stats[stat_path] < public_stat.max_score)
		preferences.storyteller_stats[stat_path] += 1
		/*
		if(increased_stat.score < increased_stat.starting_score)
				increase_base_type_stat.points += 1
			if(!increase_base_type_stat.points && !freebie_stat.points)
				return
			if(storyteller_stat_holder.get_stat(chosen_stat, FALSE) >= increase_base_type_stat.max_score)
				return
			if((storyteller_stat_holder.get_stat(chosen_stat) >= increase_base_type_stat.max_score) && increase_base_type_stat.count_bonus_score)
				return
			if(!storyteller_stat_holder.set_stat(chosen_stat, increased_stat.score + 1))
				return
			if(increase_base_type_stat.points > 0 && (increase_base_type_stat.score < increase_base_type_stat.max_level_before_freebie_points))
				increase_base_type_stat.points -= 1
			else
				if((freebie_stat.points - freebie_point_usage) < 0)
					storyteller_stat_holder.set_stat(chosen_stat, increased_stat.score - 1)
					return
				freebie_stat.points -= freebie_point_usage
		*/
		return TRUE
	return FALSE

/datum/preference_middleware/stats/proc/decrease_stat(list/params, mob/user)
	var/stat_path = text2path(params["stat"])
	var/datum/st_stat/public_stat = GLOB.public_storyteller_stats[stat_path]
	if(!public_stat) // We dont actually need public stat for this one, its just sanity to make sure you cant adjust non-existant stats
		return FALSE
	if(preferences.storyteller_stats[stat_path] > 0)
		preferences.storyteller_stats[stat_path] -= 1
		var/previous_score
		if(preferences.storyteller_stats[stat_path] < public_stat.starting_score)
			previous_score = preferences.storyteller_stat_points[stat_path]
			preferences.storyteller_stat_points[stat_path] -= 1
		if(preferences.storyteller_stat_points[stat_path] < previous_score)
			preferences.storyteller_stat_points[stat_path] += 1
		else
			preferences.storyteller_stat_points[STAT_FREEBIE_POINTS] += freebie_point_cost
		return TRUE
	return FALSE
