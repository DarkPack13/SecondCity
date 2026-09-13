/datum/st_stat/pooled/permanent_willpower
	name = "Permanent Willpower"
	description = "A character's inner drive and competence at overcoming unfavorable odds. Used for Rolls."
	subcategory = STAT_SUBCATEGORY_WILLPOWER
	freebie_point_cost = FREEBIE_COST_WILLPOWER
	stat_flags = AFFECTS_STATS
	temporary_pool = /datum/st_stat/pooled/temporary_willpower

/datum/st_stat/pooled/temporary_willpower
	name = "Temporary Willpower"
	subcategory = STAT_SUBCATEGORY_WILLPOWER
	description = "A character's inner drive and competence at overcoming unfavorable odds. Used for spendature."
	editable = FALSE
	permanent_pool = /datum/st_stat/pooled/permanent_willpower

/datum/st_stat/pooled/gnosis
	name = "Permanent Gnosis"
	subcategory = STAT_SUBCATEGORY_GNOSIS
	freebie_point_cost = FREEBIE_COST_GNOSIS
	temporary_pool = /datum/st_stat/pooled/temporary_gnosis

/datum/st_stat/pooled/gnosis/can_see_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/pooled/temporary_gnosis
	name = "Temporary Gnosis"
	subcategory = STAT_SUBCATEGORY_GNOSIS
	editable = FALSE
	temporary_pool = /datum/st_stat/pooled/temporary_gnosis

/datum/st_stat/pooled/temporary_gnosis/can_see_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/pooled/rage
	name = "Permanent Rage"
	subcategory = STAT_SUBCATEGORY_RAGE
	freebie_point_cost = FREEBIE_COST_RAGE
	temporary_pool = /datum/st_stat/pooled/temporary_rage

/datum/st_stat/pooled/rage/can_see_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/pooled/temporary_rage
	name = "Temporary Rage"
	subcategory = STAT_SUBCATEGORY_RAGE
	editable = FALSE
	permanent_pool = /datum/st_stat/pooled/temporary_rage

/datum/st_stat/pooled/temporary_rage/can_see_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE
