/datum/st_stat/discipline
	name = "Disciplines"
	abstract_type = /datum/st_stat/discipline
	category = "Discipline"
	starting_score = 1
	score = 1
	points = 12
	freebie_point_cost = FREEBIE_COST_DISIPLINE
	var/datum/discipline/discipline_type

//used for making subtypes like /datum/st_stat/discipline/celerity for instance
/datum/st_stat/discipline/New(datum/discipline/disc_type)
	. = ..()
	if(!ispath(disc_type, /datum/discipline))
		return

	discipline_type = disc_type
	name = initial(disc_type.name)
	description = initial(disc_type.desc)


