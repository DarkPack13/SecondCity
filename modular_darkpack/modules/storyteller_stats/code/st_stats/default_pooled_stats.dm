/datum/st_stat/pooled/permanent_willpower
	name = "Permanent Willpower"
	description = "A character's inner drive and competence at overcoming unfavorable odds. Used for Rolls."
	subcategory = "Willpower"
	freebie_point_cost = FREEBIE_COST_WILLPOWER
	stat_flags = AFFECTS_STATS

/datum/st_stat/pooled/temporary_willpower
	name = "Temporary Willpower"
	subcategory = "Willpower"
	description = "A character's inner drive and competence at overcoming unfavorable odds. Used for spendature."
	editable = FALSE


/datum/st_stat/pooled/gnosis
	name = "Permenent Gnosis"
	subcategory = "Gnosis"
	freebie_point_cost = FREEBIE_COST_GNOSIS

/datum/st_stat/pooled/gnosis/can_have_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/pooled/temporary_gnosis
	name = "Temporary Gnosis"
	subcategory = "Gnosis"
	editable = FALSE

/datum/st_stat/pooled/temporary_gnosis/can_have_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/pooled/rage
	name = "Permenent Rage"
	subcategory = "Rage"
	freebie_point_cost = FREEBIE_COST_RAGE

/datum/st_stat/pooled/rage/can_have_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/pooled/temporary_rage
	name = "Temporary Rage"
	subcategory = "Rage"
	editable = FALSE

/datum/st_stat/pooled/temporary_rage/can_have_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE
