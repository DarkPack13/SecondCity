
/datum/st_stat
	//determines the base type for this class, so we don't add in empty types
	abstract_type = /datum/st_stat

	var/name = ""
	var/description = ""
	var/category = ""
	var/subcategory = ""
	VAR_PROTECTED/score = 0
	var/bonus_score = 0
	//The minimum score this stat can be.
	var/min_score = 0
	//The maximum score this stat can be.
	var/max_score = 5

	var/xp_cost = 0
	var/freebie_point_cost = 0

	//if a stat affects the hp pool, recalculate the hp of the mob when changed.
	var/affects_health_pool = FALSE
	//if a stat affects the willpower pool.
	var/affects_willpower = FALSE
	//If a stat affects the player's speed, such as dexterity.
	var/affects_speed = FALSE

	//if the user can spend points on that stat.
	var/editable = TRUE

	/// A dictionary of modifiers to this attribute.
	var/list/modifiers = list()
	//What score does this stat start out with at character creation.
	var/starting_score = 0
	//How many points are in this stat category that the player can use.
	var/points = 0
	//At what score amount further upgrades require freebie point expendature to level up.
	var/max_level_before_freebie_points = 5
	//If the preferences menu should count the bonus score as a normal score, used for things like willpower.
	var/count_bonus_score = FALSE

/datum/st_stat/proc/get_score(include_bonus = TRUE)
	if(include_bonus)
		return score + bonus_score
	else
		return score

/datum/st_stat/proc/can_set_score(amount)
	var/new_score = score + amount
	if((new_score < min_score) || (new_score > max_score))
		return FALSE
	return TRUE

/datum/st_stat/proc/set_score(amount)
	if(!can_set_score(amount))
		return FALSE
	score = clamp(amount, min_score, max_score)
	return TRUE

/datum/st_stat/proc/can_increase_score(amount)
	var/new_score = score + amount
	if(new_score > max_score)
		return FALSE
	return TRUE

/datum/st_stat/proc/increase_score(amount)
	if(!can_increase_score(amount))
		return FALSE
	score = clamp(score + amount, min_score, max_score)
	return TRUE

/datum/st_stat/proc/can_decrease_score(amount)
	var/new_score = score - amount
	if(new_score < min_score)
		return FALSE
	return TRUE

/datum/st_stat/proc/decrease_score(amount)
	if(!can_decrease_score(amount))
		return FALSE
	score = clamp(score - amount, min_score, max_score)
	return TRUE

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
