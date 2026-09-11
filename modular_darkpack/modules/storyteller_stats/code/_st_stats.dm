/datum/st_stat
	//determines the base type for this class, so we don't add in empty types
	abstract_type = /datum/st_stat
	/// The name of the stat
	var/name = ""
	/// The description of the stat, shown when hovering over it in the UI.
	var/description = ""
	/// The category this stat belongs to. For example, "Attribute" or "Ability".
	var/category = ""
	/// The subcategory this stat belongs to. For example, "Physical" or "Social".
	var/subcategory = ""
	/// The current score of this stat.
	VAR_PROTECTED/score = 0
	/// Temporary bonus score applied to this stat from various ingame sources.
	VAR_PROTECTED/bonus_score = 0
	/// Temporary bonus score applied to this stat from various ingame sources. These are directly added to results rather then added to dice pool
	VAR_PROTECTED/auto_success_score = 0
	/// Temporary number that clamps a stat to less-then or equal to said value
	VAR_PROTECTED/stat_clamp_score
	/// The minimum score this stat can be.
	var/min_score = 0
	/// The maximum score this stat can be.
	var/max_score = 5
	/// The amount of freebie points that are required to increase this stat by 1 point.
	var/freebie_point_cost = 0
	/// Flags for stats, such as if it affects health.
	var/stat_flags = NONE

	/// The linked that that this controls its max pool of
	var/datum/st_stat/temporary_pool
	/// Stat pool we religate our true max score to.
	var/datum/st_stat/permanent_pool

	/// LAZYLIST. A dictionary of modifiers to this attribute.
	var/list/modifiers
	/// LAZYLIST. A dictionary of auto success scores to this attribute.
	var/list/auto_successes
	/// LAZYLIST. A dictionary of stat clamps to this attribute.
	var/list/stat_clamps

	/// If the user can spend points on that stat.
	var/editable = TRUE
	/// What score does this stat start out with at character creation.
	var/starting_score = 0
	/// What parent stat we use for freebie points
	var/freebie_pool_stat
	/// How many points are in this stat category that the player can use.
	VAR_PROTECTED/points = 0
	/// How many freebie points were spent on this stat.
	var/freebie_cost_spent = 0

// Score
/datum/st_stat/proc/get_pure_score()
	return score

/datum/st_stat/proc/get_score(include_bonus = TRUE, include_auto_sucesses = TRUE, include_stat_clamps = TRUE)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/using_score = score
	if(include_bonus)
		using_score += bonus_score
	if(include_auto_sucesses)
		using_score += auto_success_score

	if(include_stat_clamps && !isnull(stat_clamp_score))
		return min(using_score, stat_clamp_score)
	return using_score

/datum/st_stat/proc/get_bonus_score()
	SHOULD_NOT_OVERRIDE(TRUE)
	return bonus_score

/datum/st_stat/proc/get_auto_success_score()
	SHOULD_NOT_OVERRIDE(TRUE)
	return auto_success_score

/datum/st_stat/proc/can_set_score(amount, list/stat_list, care_about_clamp = FALSE)
	SHOULD_NOT_OVERRIDE(TRUE)
	/*
	 * Not really needed in alot of situations If we are asking "is this value too high or low" we should check that manually,
	 * otherwise we have situations like "refill willpower by 10" but it gets blocked because the value is technicly over the max but we dont care.
	*/
	if(care_about_clamp)
		return amount >= min_score && amount <= get_effective_max_score()
	return TRUE

/datum/st_stat/proc/can_change_score(amount, list/stat_list, care_about_clamp = FALSE)
	SHOULD_NOT_OVERRIDE(TRUE)
	return can_set_score(score + amount, stat_list, care_about_clamp)

/datum/st_stat/proc/set_score(amount, list/stat_list)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!can_set_score(amount, stat_list))
		return FALSE
	score = clamp(amount, min_score, get_effective_max_score())
	return score

/datum/st_stat/proc/change_score(amount, list/stat_list)
	SHOULD_NOT_OVERRIDE(TRUE)
	return set_score(score + amount, stat_list)

/// Returns the effective max score, relying on a teathered max score when relevent.
/datum/st_stat/proc/get_effective_max_score(list/stat_list)
	if(permanent_pool && stat_list)
		if(stat_list[permanent_pool])
			var/datum/st_stat/permanent_stat = stat_list[permanent_pool]
			return permanent_stat.get_score()
		else
			stack_trace("[src] has a defined perm pool but failed to find it in passed stat list")

	return max_score
// Modifiers

/datum/st_stat/proc/add_stat_mod(amount, source)
	SHOULD_NOT_OVERRIDE(TRUE)
	LAZYSET(modifiers, source, amount)
	update_modifiers()

/datum/st_stat/proc/remove_stat_mod(source)
	SHOULD_NOT_OVERRIDE(TRUE)
	LAZYREMOVE(modifiers, source)
	update_modifiers()

/datum/st_stat/proc/update_modifiers()
	SHOULD_NOT_OVERRIDE(TRUE)
	bonus_score = initial(bonus_score)
	for(var/source in modifiers)
		bonus_score += modifiers[source]
	bonus_score = clamp(bonus_score, -max_score, 10)


/datum/st_stat/proc/add_auto_successes(amount, source)
	SHOULD_NOT_OVERRIDE(TRUE)
	LAZYSET(auto_successes, source, amount)
	update_auto_successes()

/datum/st_stat/proc/remove_auto_successes(source)
	SHOULD_NOT_OVERRIDE(TRUE)
	LAZYREMOVE(auto_successes, source)
	update_auto_successes()

/datum/st_stat/proc/update_auto_successes()
	SHOULD_NOT_OVERRIDE(TRUE)
	auto_success_score = initial(auto_success_score)
	for(var/source in auto_successes)
		auto_success_score += auto_successes[source]
	auto_success_score = clamp(auto_success_score, 0, 10)


/datum/st_stat/proc/add_stat_clamps(amount, source)
	SHOULD_NOT_OVERRIDE(TRUE)
	LAZYSET(stat_clamps, source, amount)
	update_stat_clamps()

/datum/st_stat/proc/remove_stat_clamps(source)
	SHOULD_NOT_OVERRIDE(TRUE)
	LAZYREMOVE(stat_clamps, source)
	update_stat_clamps()

/datum/st_stat/proc/update_stat_clamps()
	SHOULD_NOT_OVERRIDE(TRUE)
	stat_clamp_score = null
	for(var/source in stat_clamps)
		if(isnull(stat_clamp_score) || (stat_clamps[source] <= stat_clamp_score))
			stat_clamp_score = stat_clamps[source]

// Points

/datum/st_stat/proc/get_points()
	SHOULD_NOT_OVERRIDE(TRUE)
	return points

/datum/st_stat/proc/can_set_points(amount, list/stat_list)
	SHOULD_NOT_OVERRIDE(TRUE)
	return TRUE
	// return amount >= min_points && amount <= max_points

/datum/st_stat/proc/can_change_points(amount, list/stat_list)
	SHOULD_NOT_OVERRIDE(TRUE)
	return can_set_points(points + amount, stat_list)

/datum/st_stat/proc/set_points(amount, list/stat_list)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!can_set_points(amount, stat_list))
		return FALSE
	points = amount
	// points = clamp(amount, min_points, max_points)
	return TRUE

/datum/st_stat/proc/change_points(amount, list/stat_list)
	SHOULD_NOT_OVERRIDE(TRUE)
	return set_points(points + amount, stat_list)

// Freebie Points

/datum/st_stat/proc/can_increase_freebie_points(amount)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(freebie_cost_spent <= 0)
		return FALSE
	return TRUE

/datum/st_stat/proc/increase_freebie_points(amount)
	SHOULD_NOT_OVERRIDE(TRUE)
	points += amount
	freebie_cost_spent -= amount
	return TRUE

/datum/st_stat/proc/can_decrease_freebie_points(amount)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/new_points = points - amount
	if(new_points < 0)
		return FALSE
	return TRUE

/datum/st_stat/proc/decrease_freebie_points(amount)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!can_decrease_freebie_points(amount))
		return FALSE
	points -= amount
	freebie_cost_spent += amount
	return TRUE

/datum/st_stat/proc/link_mob(mob/living/our_mob)
	return

/datum/st_stat/proc/unlink_mob(mob/living/our_mob)
	return

/datum/st_stat/proc/update_mob(mob/living/our_mob, initial)
	return

/// Wether or not the stat can be seen on the character sheet, values are still often tracked for sanity reasons.
/datum/st_stat/proc/can_see_stat(mob/owner)
	return TRUE
