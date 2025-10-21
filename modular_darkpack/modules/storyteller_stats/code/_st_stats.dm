
/datum/st_stat
	var/name = ""
	var/description = ""
	var/score = 0
	var/bonus_score = 0

	//determines the base type for this class, so we don't add in empty types
	var/base_type = /datum/st_stat

	//if a stat affects the hp pool, recalculate the hp of the mob when changed.
	var/affects_health_pool = FALSE

	/// A dictionary of modifiers to this attribute.
	var/list/modifiers = list()

/datum/st_stat/proc/get_score(include_bonus = TRUE)
	if(include_bonus)
		return score + bonus_score
	else
		return score

/datum/st_stat/proc/set_score(amount)
	score = amount

/datum/st_stat/proc/update_modifiers()
	SHOULD_NOT_OVERRIDE(TRUE)
	bonus_score = initial(bonus_score)
	for(var/source in modifiers)
		bonus_score += modifiers[source]
	bonus_score = clamp(bonus_score, 0, 10)

/datum/st_stat/proc/get_score_multiplier(low_mod = 0.25, high_mod = 2)
	var/used_score = score + bonus_score
	// used max_score when it exists
	var/max_score = 5
	used_score = clamp(used_score, 0, max_score)

	var/mult = low_mod + ((used_score / max_score) * (high_mod - low_mod))

	return mult
