// Namespace subsystem really
SUBSYSTEM_DEF(stats)
	name = "Storyteller Stats"
	flags = SS_NO_INIT | SS_NO_FIRE

/datum/controller/subsystem/stats/proc/sanitize_stat_list(passed_stats)
	var/new_list = list()
	for(var/stat_path in GLOB.public_storyteller_stats)
		var/datum/st_stat/stat = GLOB.public_storyteller_stats[stat_path]
		var/score = stat.get_score(FALSE)
		if(stat_path in passed_stats)
			score = passed_stats[stat_path]
		new_list[stat_path] = score
	return new_list

/datum/controller/subsystem/stats/proc/sanitize_points_list(passed_stats)
	if(passed_stats)
		return passed_stats
	var/new_list = init_storyteller_stat_points()
	return new_list

/datum/controller/subsystem/stats/proc/apply_stats_from_prefs(mob/living/user, client/applied_client)
	for(var/stat_path in applied_client.prefs.storyteller_stats)
		user.storyteller_stat_holder.set_stat(stat_path, applied_client.prefs.storyteller_stats[stat_path])
