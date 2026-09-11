GLOBAL_ALIST_INIT(stat_typepath_migration, list(
	"/datum/st_stat/attribute/strength" = /datum/st_stat/attribute/physical/strength,
	"/datum/st_stat/attribute/dexterity" = /datum/st_stat/attribute/physical/dexterity,
	"/datum/st_stat/attribute/stamina" = /datum/st_stat/attribute/physical/stamina,
	"/datum/st_stat/attribute/charisma" = /datum/st_stat/attribute/social/charisma,
	"/datum/st_stat/attribute/manipulation" = /datum/st_stat/attribute/social/manipulation,
	"/datum/st_stat/attribute/appearance" = /datum/st_stat/attribute/social/appearance,
	"/datum/st_stat/attribute/perception" = /datum/st_stat/attribute/mental/perception,
	"/datum/st_stat/attribute/intelligence" = /datum/st_stat/attribute/mental/intelligence,
	"/datum/st_stat/attribute/wits" = /datum/st_stat/attribute/mental/wits,
	"/datum/st_stat/ability/alertness" = /datum/st_stat/ability/talent/alertness,
	"/datum/st_stat/ability/athletics" = /datum/st_stat/ability/talent/athletics,
	"/datum/st_stat/ability/awareness" = /datum/st_stat/ability/talent/awareness,
	"/datum/st_stat/ability/brawl" = /datum/st_stat/ability/talent/brawl,
	"/datum/st_stat/ability/empathy" = /datum/st_stat/ability/talent/empathy,
	"/datum/st_stat/ability/expression" = /datum/st_stat/ability/talent/expression,
	"/datum/st_stat/ability/intimidation" = /datum/st_stat/ability/talent/intimidation,
	"/datum/st_stat/ability/leadership" = /datum/st_stat/ability/talent/leadership,
	"/datum/st_stat/ability/primary_urge" = /datum/st_stat/ability/talent/primary_urge,
	"/datum/st_stat/ability/streetwise" = /datum/st_stat/ability/talent/streetwise,
	"/datum/st_stat/ability/subterfuge" = /datum/st_stat/ability/talent/subterfuge,
	"/datum/st_stat/ability/animal_ken" = /datum/st_stat/ability/skill/animal_ken,
	"/datum/st_stat/ability/crafts" = /datum/st_stat/ability/skill/crafts,
	"/datum/st_stat/ability/drive" = /datum/st_stat/ability/skill/drive,
	"/datum/st_stat/ability/etiquette" = /datum/st_stat/ability/skill/etiquette,
	"/datum/st_stat/ability/firearms" = /datum/st_stat/ability/skill/firearms,
	"/datum/st_stat/ability/larceny" = /datum/st_stat/ability/skill/larceny,
	"/datum/st_stat/ability/melee" = /datum/st_stat/ability/skill/melee,
	"/datum/st_stat/ability/performance" = /datum/st_stat/ability/skill/performance,
	"/datum/st_stat/ability/stealth" = /datum/st_stat/ability/skill/stealth,
	"/datum/st_stat/ability/survival" = /datum/st_stat/ability/skill/survival,
	"/datum/st_stat/ability/academics" = /datum/st_stat/ability/knowledge/academics,
	"/datum/st_stat/ability/computer" = /datum/st_stat/ability/knowledge/computer,
	"/datum/st_stat/ability/finance" = /datum/st_stat/ability/knowledge/finance,
	"/datum/st_stat/ability/investigation" = /datum/st_stat/ability/knowledge/investigation,
	"/datum/st_stat/ability/law" = /datum/st_stat/ability/knowledge/law,
	"/datum/st_stat/ability/medicine" = /datum/st_stat/ability/knowledge/medicine,
	"/datum/st_stat/ability/occult" = /datum/st_stat/ability/knowledge/occult,
	"/datum/st_stat/ability/politics" = /datum/st_stat/ability/knowledge/politics,
	"/datum/st_stat/ability/rituals" = /datum/st_stat/ability/knowledge/rituals,
	"/datum/st_stat/ability/science" = /datum/st_stat/ability/knowledge/science,
	"/datum/st_stat/ability/technology" = /datum/st_stat/ability/knowledge/technology,
))

/proc/create_new_st_stats(list/passed_list)
	var/list/stats_list = list()
	for(var/datum/st_stat/stat_path as anything in subtypesof(/datum/st_stat))
		if((stat_path::abstract_type == stat_path) && (stat_path::freebie_pool_stat != stat_path))
			continue
		var/datum/st_stat/stat = new stat_path()
		stat.set_score(stat.starting_score, passed_list)
		stats_list[stat_path] = stat
	passed_list = stats_list
	update_middleware_stats(passed_list)
	return sortTim(passed_list, GLOBAL_PROC_REF(cmp_st_stat_asc), associative = TRUE)

// This entire snowflake code is done purely so that we can properly update stats that are based on other stats.
/proc/update_middleware_stats(list/preference_storyteller_stats)
	var/datum/st_stat/stat_courage = preference_storyteller_stats[STAT_COURAGE]
	var/datum/st_stat/stat_permenant_willpower = preference_storyteller_stats[STAT_PERMANENT_WILLPOWER]
	stat_permenant_willpower.add_stat_mod(clamp(-(stat_permenant_willpower.get_pure_score() - 10), 0, stat_courage.get_score(include_bonus = TRUE)), "COURAGE")
	var/datum/st_stat/stat_temporary_willpower = preference_storyteller_stats[STAT_TEMPORARY_WILLPOWER]
	stat_temporary_willpower.set_score(stat_permenant_willpower.get_score(include_bonus = TRUE), preference_storyteller_stats)

	var/datum/st_stat/morality_path/morality/stat_morality = preference_storyteller_stats[STAT_MORALITY]
	if(stat_morality?.morality_path)
		var/datum/st_stat/stat_conscience = preference_storyteller_stats[STAT_CONSCIENCE]
		var/datum/st_stat/stat_self_control = preference_storyteller_stats[STAT_SELF_CONTROL]
		var/datum/st_stat/stat_conviction = preference_storyteller_stats[STAT_CONVICTION]
		var/datum/st_stat/stat_instinct = preference_storyteller_stats[STAT_INSTINCT]

		if(stat_morality.morality_path.alignment == MORALITY_HUMANITY)
			stat_morality.set_score(
				clamp(stat_conscience.get_score(include_bonus = TRUE) + stat_self_control.get_score(include_bonus = TRUE), 0, 10),
				preference_storyteller_stats
			)
		else if(stat_morality.morality_path.alignment == MORALITY_ENLIGHTENMENT)
			stat_morality.set_score(
				clamp(stat_conviction.get_score(include_bonus = TRUE) + stat_instinct.get_score(include_bonus = TRUE), 0, 10),
				preference_storyteller_stats
			)


/datum/preferences/proc/load_st_stat_from_save(list/pref_save)
	var/list/failed_loads = list()
	var/list/new_stat_list = list()
	for(var/stat_path in pref_save)
		var/datum/st_stat/proper_stat_path
		if(ispath(stat_path, /datum/st_stat))
			// I thought when its saved it becomes a string but that seems to not always be the case?
			// I belive its because the json handling is held in byond after the first fetch?
			proper_stat_path = stat_path
		else
			proper_stat_path = text2path(stat_path)
			if(!proper_stat_path && GLOB.stat_typepath_migration[stat_path])
				proper_stat_path = GLOB.stat_typepath_migration[stat_path]
		if(!proper_stat_path)
			failed_loads += "[stat_path] ([pref_save[stat_path][STAT_SCORE]])"
			continue

		// How did we even make this... whatever.
		if((proper_stat_path::abstract_type == proper_stat_path) && (proper_stat_path::freebie_pool_stat != proper_stat_path))
			continue

		var/datum/st_stat/stat = new proper_stat_path()
		stat.set_score(pref_save[stat_path][STAT_SCORE], new_stat_list)
		stat.set_points(pref_save[stat_path][STAT_POINTS])
		stat.freebie_cost_spent = pref_save[stat_path][STAT_FREEBIE_COST_SPENT]
		new_stat_list[proper_stat_path] = stat

	if(failed_loads.len)
		var/real_name = read_preference(/datum/preference/name/real_name)
		var/message = "Some stats on [real_name] failed to load and wont be saved. You likely need to reset your stats. Bad entries:<br>[jointext(failed_loads, "<br>")]"

		if(parent)
			to_chat(parent, boxed_message(span_warning(message)))

		log_stats("Game loaded [real_name] but had bad stats saved: <br> [jointext(failed_loads, " <br> ")]")

	add_missing_st_stats(new_stat_list)

	update_middleware_stats(new_stat_list)

	return sortTim(new_stat_list, GLOBAL_PROC_REF(cmp_st_stat_asc), associative = TRUE)

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
		stat.set_score(stat.starting_score, passed_list)
		passed_list[stat_path] = stat
		new_stats += stat.name

	if(new_stats.len && parent)
		var/real_name = read_preference(/datum/preference/name/real_name)
		to_chat(parent, boxed_message(span_notice("Gained new stats on [real_name]:<br>[jointext(new_stats, ", ")]")))


/proc/cmp_st_stat_asc(datum/st_stat/a, datum/st_stat/b)
	var/static/list/sorted_cat = list(
		STAT_CATEGORY_ATTRIBUTE,
		STAT_CATEGORY_ABILITY,
		STAT_CATEGORY_ADVANTAGES,
		STAT_CATEGORY_POOLED,
	)
	var/static/list/sorted_subcat = list(
		STAT_SUBCATEGORY_PHYSICAL,
		STAT_SUBCATEGORY_SOCIAL,
		STAT_SUBCATEGORY_MENTAL,
		STAT_SUBCATEGORY_TALENTS,
		STAT_SUBCATEGORY_SKILLS,
		STAT_SUBCATEGORY_KNOWLEDGES,
		STAT_SUBCATEGORY_VIRTUES,
	)
	var/static/list/sorted_manual_type = list(
		STAT_STRENGTH,
		STAT_DEXTERITY,
		STAT_STAMINA,
		STAT_CHARISMA,
		STAT_MANIPULATION,
		STAT_APPEARANCE,
		STAT_PERCEPTION,
		STAT_INTELLIGENCE,
		STAT_WITS,
		STAT_CONSCIENCE,
		STAT_CONVICTION,
		STAT_SELF_CONTROL,
		STAT_INSTINCT,
		STAT_COURAGE
	)


	if(a.category && b.category && (a.category != b.category))
		var/a_cat = sorted_cat.Find(a.category)
		var/b_cat = sorted_cat.Find(b.category)

		if(a_cat != b_cat)
			return a_cat - b_cat

	if(a.subcategory && b.subcategory && (a.subcategory != b.subcategory))
		var/a_subcat = sorted_subcat.Find(a.subcategory)
		var/b_subcat = sorted_subcat.Find(b.subcategory)

		if(a_subcat != b_subcat)
			return a_subcat - b_subcat

	if((a.type in sorted_manual_type) && (b.type in sorted_manual_type))
		var/a_index = sorted_manual_type.Find(a.type)
		var/b_index = sorted_manual_type.Find(b.type)
		return a_index - b_index

	return sorttext("[b.type]", "[a.type]")
