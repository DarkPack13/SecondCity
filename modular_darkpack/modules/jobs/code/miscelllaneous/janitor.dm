/datum/job/vampire/janitor
	title = JOB_STREET_JANITOR
	department_head = /datum/job/vampire/prince
	faction = FACTION_CITY
	total_positions = 6
	spawn_positions = 6
	supervisors = SUPERVISOR_CAMARILLA
	config_tag = "JANITOR"
	outfit = /datum/outfit/job/vampire/janitor
	job_flags = CITY_JOB_FLAGS
	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)
	department_for_prefs = /datum/job_department/city_services
	departments_list = list(
		/datum/job_department/city_services,
	)
	display_order = JOB_DISPLAY_ORDER_STREETJAN
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF)

	description = "Keep the streets clean. You are paid to keep your mouth shut about the things you see."
	minimal_masquerade = 0

/datum/outfit/job/vampire/janitor
	name = "Street Janitor"
	jobtype = /datum/job/vampire/janitor

	id = /obj/item/card/cleaning
	uniform = /obj/item/clothing/under/vampire/janitor
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/cleaning
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	gloves = /obj/item/clothing/gloves/vampire/cleaning
	backpack_contents = list(/obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/vamp/keys/hack=1, /obj/item/card/credit=1)

/obj/effect/landmark/start/janitor
	name = "Street Janitor"
	icon_state = "Street Janitor"
