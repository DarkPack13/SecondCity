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
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_OLD_CLAN_TZIMISCE, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_GARGOYLE)

/datum/outfit/job/vampire/citizen
	name = JOB_CITIZEN
	jobtype = /datum/job/vampire/citizen
	//l_pocket = /obj/item/vamp/phone
	id = /obj/item/watch
	backpack_contents = list(/obj/item/passport, /obj/item/flashlight, /obj/item/card/credit)

/obj/effect/landmark/start/citizen
	name = "Citizen"
	icon_state = "Assistant"
