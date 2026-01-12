/datum/job/vampire/citizen
	title = JOB_CITIZEN
	description = "Obey the authorities... Or don't. You are up late tonight for one reason or another."
	faction = FACTION_CITY
	total_positions = -1
	spawn_positions = -1
	outfit = /datum/outfit/job/vampire/citizen
	exp_granted_type = EXP_TYPE_KINDRED
	config_tag = "CITIZEN"
	display_order = JOB_DISPLAY_ORDER_CITIZEN
	department_for_prefs = /datum/job_department/citizen
	job_flags = CITY_JOB_FLAGS
	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)
	minimal_masquerade = 0

/datum/outfit/job/vampire/citizen
	name = JOB_CITIZEN
	jobtype = /datum/job/vampire/citizen
	l_pocket = /obj/item/smartphone
	backpack_contents = list(/obj/item/card/credit)
