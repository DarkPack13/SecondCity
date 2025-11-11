GLOBAL_LIST_INIT(public_storyteller_stats, init_public_storyteller_stats())
GLOBAL_LIST_INIT(private_storyteller_stats, init_private_storyteller_stats())

/proc/init_public_storyteller_stats()
	var/list/stat_list = list()
	for(var/datum/st_stat/path as anything in valid_subtypesof(/datum/st_stat))
		var/datum/st_stat/new_trait = new path
		stat_list[path] = new_trait
	return stat_list

/proc/init_private_storyteller_stats()
	var/list/stat_list = list()
	for(var/datum/st_stat/path as anything in subtypesof(/datum/st_stat))
		var/datum/st_stat/new_trait = new path
		stat_list[path] = new_trait
	return stat_list

/proc/init_storyteller_stat_points()
	var/list/stat_list = list()
	for(var/datum/st_stat/path as anything in subtypesof(/datum/st_stat))
		if(path != path.abstract_type)
			continue
		var/datum/st_stat/new_trait = new path
		if(!new_trait.points)
			continue
		stat_list[path] = new_trait.points
	return stat_list
