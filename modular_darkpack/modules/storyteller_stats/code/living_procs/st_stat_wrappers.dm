//wrapper for retrieving a st_stat datum from the storyteller stat holder
/mob/living/proc/st_get_stat_datum(stat_path)
	RETURN_TYPE(/datum/st_stat)
	if(!storyteller_stat_holder)
		return null
	return storyteller_stat_holder.get_stat_datum(stat_path)

//wrapper for getting a stat in the storyteller stat holder
/mob/living/proc/st_get_stat(stat_path, include_bonus = TRUE)
	if(!storyteller_stat_holder)
		return 0
	return storyteller_stat_holder.get_stat(stat_path, include_bonus)

/*
* wrapper for setting a stat's value in the storyteller stat holder
* Causes total hp recalculation if the modded stat affects the hp pool.
*/
/mob/living/proc/st_set_stat(stat_path, amount)
	if(storyteller_stat_holder)
		storyteller_stat_holder.set_stat(stat_path, amount)
	if(storyteller_stat_holder.is_health_affecting(stat_path))
		recalculate_max_health(TRUE)

//wrapper for adding a stat modifier in the storyteller stat holder
/mob/living/proc/st_add_stat_mod(stat_path, amount, source)
	if(!storyteller_stat_holder)
		return
	storyteller_stat_holder.add_stat_mod(stat_path, amount, source)
	if(storyteller_stat_holder.is_health_affecting(stat_path))
		recalculate_max_health()

//wrapper for removing a stat modifier in the storyteller stat holder
/mob/living/proc/st_remove_stat_mod(stat_path, source)
	if(!storyteller_stat_holder)
		return
	storyteller_stat_holder.remove_stat_mod(stat_path, source)
	if(storyteller_stat_holder.is_health_affecting(stat_path))
		recalculate_max_health()

/mob/living/proc/st_get_stat_mod(stat_path, source)
	if(!storyteller_stat_holder)
		return
	return storyteller_stat_holder.get_stat_mod(stat_path, source)

/mob/living/proc/st_stat_multiplier(stat_path, low_mod, high_mod)
	if(!storyteller_stat_holder)
		return 1
	return storyteller_stat_holder.get_stat_multiplier(stat_path, low_mod, high_mod)
