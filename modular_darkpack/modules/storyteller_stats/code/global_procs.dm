/proc/create_new_st_stats(list/passed_list)
	var/list/stats_list = list()
	for(var/datum/st_stat/stat_path as anything in subtypesof(/datum/st_stat))
		if((stat_path::abstract_type == stat_path) && (stat_path::freebie_pool_stat != stat_path))
			continue
		var/datum/st_stat/stat = new stat_path()
		stat.set_score(stat.starting_score)
		stats_list[stat_path] = stat
	passed_list = stats_list
	update_middleware_stats(passed_list)
	return passed_list

// This entire snowflake code is done purely so that we can properly update stats that are based on other stats.
/proc/update_middleware_stats(list/preference_storyteller_stats)
	var/datum/st_stat/stat_courage = preference_storyteller_stats[STAT_COURAGE]
	var/datum/st_stat/stat_permenant_willpower = preference_storyteller_stats[STAT_PERMANENT_WILLPOWER]
	stat_permenant_willpower.add_stat_mod(clamp(-(stat_permenant_willpower.get_score(include_bonus = FALSE) - 10), 0, stat_courage.get_score(include_bonus = TRUE)), "COURAGE")
	var/datum/st_stat/stat_temporary_willpower = preference_storyteller_stats[STAT_TEMPORARY_WILLPOWER]
	stat_temporary_willpower.set_score(stat_permenant_willpower.get_score(include_bonus = TRUE))

	var/datum/st_stat/morality_path/morality/stat_morality = preference_storyteller_stats[STAT_MORALITY]
	if(stat_morality?.morality_path)
		var/datum/st_stat/stat_conscience = preference_storyteller_stats[STAT_CONSCIENCE]
		var/datum/st_stat/stat_self_control = preference_storyteller_stats[STAT_SELF_CONTROL]
		var/datum/st_stat/stat_conviction = preference_storyteller_stats[STAT_CONVICTION]
		var/datum/st_stat/stat_instinct = preference_storyteller_stats[STAT_INSTINCT]

		if(stat_morality.morality_path.alignment == MORALITY_HUMANITY)
			stat_morality.set_score(clamp(stat_conscience.get_score(include_bonus = TRUE) + stat_self_control.get_score(include_bonus = TRUE), 0, 10))
		else if(stat_morality.morality_path.alignment == MORALITY_ENLIGHTENMENT)
			stat_morality.set_score(clamp(stat_conviction.get_score(include_bonus = TRUE) + stat_instinct.get_score(include_bonus = TRUE), 0, 10))


/datum/preferences/proc/load_st_stat_from_save(list/pref_save)
	var/list/failed_loads = list()
	var/list/new_stat_list = list()
	for(var/stat_path in pref_save)
		var/proper_stat_path
		if(ispath(stat_path, /datum/st_stat))
			// I thought when its saved it becomes a string but that seems to not always be the case?
			// I belive its because the json handling is held in byond after the first fetch?
			proper_stat_path = stat_path
		else
			proper_stat_path = text2path(stat_path)
		if(!proper_stat_path)
			failed_loads += "[stat_path] ([pref_save[stat_path][STAT_SCORE]])"
			continue
		var/datum/st_stat/stat = new proper_stat_path()
		stat.set_score(pref_save[stat_path][STAT_SCORE])
		stat.set_points(pref_save[stat_path][STAT_POINTS])
		stat.freebie_cost_spent = pref_save[stat_path][STAT_FREEBIE_COST_SPENT]
		new_stat_list[proper_stat_path] = stat

	if(failed_loads.len)
		var/real_name = read_preference(/datum/preference/name/real_name)
		var/message = "Some stats on [real_name] failed to load and wont be saved. You likely need to reset your stats. Bad entries:<br>[jointext(failed_loads, "<br>")]"

		to_chat(parent, boxed_message(span_warning(message)))

		log_stats("Game loaded [real_name] but had bad stats saved: <br> [jointext(failed_loads, " <br> ")]")

	add_missing_st_stats(new_stat_list)

	update_middleware_stats(new_stat_list)

	return new_stat_list

// Not garuneteed to create a valid sheet as it still wont refund points to any lost in a data transfer. A reset is still likely smart.
/// Go through and fill out any stats that are missing from the list.
/datum/preferences/proc/add_missing_st_stats(list/passed_list)
	var/list/new_stats = list()
	for(var/datum/st_stat/stat_path as anything in subtypesof(/datum/st_stat))
		if((stat_path::abstract_type == stat_path) && (stat_path::freebie_pool_stat != stat_path))
			continue
		if(passed_list[stat_path])
			continue
		var/datum/st_stat/stat = new stat_path()
		stat.set_score(stat.starting_score)
		passed_list[stat_path] = stat
		new_stats += stat.name

	if(new_stats && usr)
		to_chat(usr, boxed_message(span_notice("Gained new stats:<br>[jointext(new_stats, ", ")]")))
