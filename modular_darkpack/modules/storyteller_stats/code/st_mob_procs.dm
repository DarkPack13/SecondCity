// Get a specific mob's stat from its stats list.
/mob/living/proc/st_get_stat(stat_path, include_bonus)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	return given_stat?.get_score(include_bonus)

// Set a specific mob's stat from its stats list.
/mob/living/proc/st_set_stat(stat_path, amount)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	return given_stat?.set_score(amount)

/mob/living/proc/st_add_stat_mod(stat_path, amount, source)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	return given_stat?.add_stat_mod(amount, source)

/mob/living/proc/st_remove_stat_mod(stat_path, source)
	var/datum/st_stat/given_stat = storyteller_stats[stat_path]
	return given_stat?.remove_stat_mod(source)

/mob/living/proc/apply_stats_from_prefs(list/prefs_list)
	storyteller_stats = client?.prefs?.preference_storyteller_stats.Copy()
