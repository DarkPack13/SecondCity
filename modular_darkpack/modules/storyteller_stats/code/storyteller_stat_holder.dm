/// This is the object used to store and manage a character's st_stats.
/datum/storyteller_stats
	/// A dictionary of st_stats. K: path -> V: instance.
	VAR_PRIVATE/list/st_stats = list()

/datum/storyteller_stats/New()
	. = ..()
	for(var/datum/st_stat/path as anything in valid_subtypesof(/datum/st_stat))
		var/datum/st_stat/new_trait = new path
		st_stats[path] = new_trait
		set_stat(path, new_trait.starting_score)

/datum/storyteller_stats/Destroy()
	st_stats = null
	return ..()

/// Return the total or pure score of the given stat.
/datum/storyteller_stats/proc/get_stat(stat_path, include_bonus = TRUE)
	var/datum/st_stat/A = st_stats[stat_path]
	return A.get_score(include_bonus)

/// Sets the score of the given stat.
/datum/storyteller_stats/proc/set_stat(stat_path, amount)
	var/datum/st_stat/A = st_stats[stat_path]
	A.set_score(amount)

/// Return the instance of the given stat.
/datum/storyteller_stats/proc/get_stat_datum(stat_path)
	RETURN_TYPE(/datum/st_stat)
	var/datum/st_stat/A = st_stats[stat_path]
	return A

/datum/storyteller_stats/proc/add_stat_mod(stat_path, amount, source)
	var/datum/st_stat/A = get_stat_datum(stat_path)
	LAZYSET(A.modifiers, source, amount)
	A.update_modifiers()

/datum/storyteller_stats/proc/remove_stat_mod(stat_path, source)
	var/datum/st_stat/A = get_stat_datum(stat_path)
	if(LAZYACCESS(A.modifiers, source))
		A.modifiers -= source
		A.update_modifiers()

/datum/storyteller_stats/proc/get_stat_mod(trait, source)
	var/datum/st_stat/checking_trait = get_stat_datum(trait)
	return LAZYACCESS(checking_trait.modifiers, source)

/datum/storyteller_stats/proc/get_stat_multiplier(stat_path, low_mod, high_mod)
	var/datum/st_stat/A = st_stats[stat_path]
	return A.get_score_multiplier(low_mod, high_mod)

/datum/storyteller_stats/proc/randomize_attributes(min_score, max_score)
	for(var/datum/st_stat/attribute/A in st_stats)
		A.set_score(rand(min_score, max_score))

/datum/storyteller_stats/proc/randomize_abilities(min_score, max_score)
	for(var/datum/st_stat/ability/A in st_stats)
		A.set_score(rand(min_score, max_score))

/datum/storyteller_stats/proc/decrease_score(stat_path, amount)
	var/datum/st_stat/A = get_stat_datum(stat_path)
	return A.decrease_score(amount)

/datum/storyteller_stats/proc/increase_score(stat_path, amount)
	var/datum/st_stat/A = get_stat_datum(stat_path)
	return A.increase_score(amount)
