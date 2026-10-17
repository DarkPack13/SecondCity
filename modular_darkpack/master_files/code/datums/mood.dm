/datum/mood
	// MOOD
	var/time_spent_max_mood = 0
	var/willpower_restored = 0
	var/max_willpower_restorable = 3

/datum/mood/process(seconds_per_tick)
	. = ..()
	// MOOD
	if(willpower_restored <= max_willpower_restorable)
		if(sanity_level == SANITY_LEVEL_GREAT)
			time_spent_max_mood += seconds_per_tick

		if(time_spent_max_mood >= 5 MINUTES)
			if(mob_parent.st_get_stat(STAT_TEMPORARY_WILLPOWER) < mob_parent.st_get_stat(STAT_PERMANENT_WILLPOWER))
				willpower_restored++
				mob_parent.adjust_willpower(1)
