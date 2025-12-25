/proc/create_new_stat_prefs(list/preference_storyteller_stats)
	var/list/stats_list = list()
	for(var/stat_path as anything in subtypesof(/datum/st_stat))
		var/datum/st_stat/stat = new stat_path()
		stat_path = "[stat_path]"
		stat.set_score(stat.starting_score)
		stats_list[stat_path] = stat
	preference_storyteller_stats = stats_list
	update_middleware_stats(preference_storyteller_stats)
	return preference_storyteller_stats

// This entire snowflake code is done purely so that we can properly update stats that are based on other stats.
/proc/update_middleware_stats(list/preference_storyteller_stats)
	var/datum/st_stat/stat_courage = preference_storyteller_stats["[STAT_COURAGE]"]
	var/datum/st_stat/stat_permenant_willpower = preference_storyteller_stats["[STAT_PERMANENT_WILLPOWER]"]
	stat_permenant_willpower.add_stat_mod(clamp(-(stat_permenant_willpower.get_score(include_bonus = FALSE) - 10), 0, stat_courage.get_score(include_bonus = TRUE)), "COURAGE")
	var/datum/st_stat/stat_temporary_willpower = preference_storyteller_stats["[STAT_TEMPORARY_WILLPOWER]"]
	stat_temporary_willpower.set_score(stat_permenant_willpower.get_score(include_bonus = TRUE))
