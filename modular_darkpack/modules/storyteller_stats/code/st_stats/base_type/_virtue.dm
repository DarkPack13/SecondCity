/datum/st_stat/virtue
	name = "Virtue Points"
	abstract_type = /datum/st_stat/virtue
	category = STAT_CATEGORY_ADVANTAGES
	subcategory = STAT_SUBCATEGORY_VIRTUES
	freebie_pool_stat = /datum/st_stat/virtue
	points = 7
	freebie_point_cost = FREEBIE_COST_VIRTUE
	stat_flags = AFFECTS_STATS

/datum/st_stat/virtue/can_have_stat(mob/owner)
	if(!get_vampire_splat(owner))
		return FALSE
	return TRUE
