/datum/job/vampire/banu
	title = JOB_BARISTA
	faction = FACTION_CITY
	total_positions = 12
	spawn_positions = 12
	supervisors = SUPERVISOR_PRIMOGEN_BANU_HAQIM
	outfit = /datum/outfit/job/banu
	config_tag = "BARISTA"
	display_order = JOB_DISPLAY_ORDER_BANU
	job_flags = CITY_JOB_FLAGS
	department_for_prefs = /datum/job_department/city_services
	departments_list = list(
		/datum/job_department/city_services,
	)
	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)
	species_slots = list(SPECIES_KINDRED = 8, SPECIES_GHOUL = 50, SPECIES_HUMAN = 50)

	description = "You work at a little quiet coffee shop in the ghetto, and you have some inkling of what goes on there - Perhaps you are a retainer or ghoul of one of the higher-tier members - Either way, you turn a blind eye to it for one reason or another."
	allowed_clans = list(VAMPIRE_CLAN_BANU_HAQIM)

/datum/outfit/job/banu
	name = "banu"
	jobtype = /datum/job/vampire/banu
	l_pocket = /obj/item/vamp/phone
	id = /obj/item/watch
	backpack_contents = list(
		/obj/item/passport = 1,
		/obj/item/flashlight = 1,
		/obj/item/card/credit = 1,
	)

/obj/effect/landmark/start/assamite
	name = "Barista"
	icon_state = "Assistant"
