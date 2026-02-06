/datum/st_stat/discipline
	name = "Disciplines"
	abstract_type = /datum/st_stat/discipline
	category = "Discipline"
	starting_score = 1
	score = 1
	max_score = 5
	points = 12
	freebie_point_cost = FREEBIE_COST_DISIPLINE

//used for making subtypes like /datum/st_stat/discipline/celerity for instance
/datum/st_stat/discipline/New(datum/discipline/disc_type)
	. = ..()
	if(!ispath(disc_type, /datum/discipline))
		return

	name = initial(disc_type.name)
	description = initial(disc_type.desc)


