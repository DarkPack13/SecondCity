
/mob/living/proc/st_get_stat(stat_path, include_bonus)
	var/datum/st_stat/given_stat = stat_path
	return given_stat?.get_score(include_bonus)

/mob/living/proc/st_set_stat(stat_path, amount)
	var/datum/st_stat/given_stat = stat_path
	return given_stat?.set_score(amount)

/mob/living/proc/st_add_stat_mod(stat_path, amount, source)
	var/datum/st_stat/given_stat = stat_path
	return given_stat?.add_stat_mod(amount, source)

/mob/living/proc/st_remove_stat_mod(stat_path, source)
	var/datum/st_stat/given_stat = stat_path
	return given_stat?.remove_stat_mod(source)

/mob/living/proc/apply_stats_from_prefs(list/prefs_list)
	var/list/new_stats_list = list()
	for(var/datum/st_stat/path as anything in valid_subtypesof(/datum/st_stat)) // For each valid stat...
		var/datum/st_stat/new_trait = new path // ...make a new stat....
		new_trait.score = clamp(prefs_list[path], 0, 10) // ...make sure the client prefs savefile is a valid score...
		new_stats_list[path] = new_trait //...apply it to the new stat...
	storyteller_stats = new_stats_list // ...an finally save the new finalized list to the mob
