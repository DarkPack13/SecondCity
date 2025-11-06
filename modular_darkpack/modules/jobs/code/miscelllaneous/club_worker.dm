/datum/job/vampire/club_worker
	title = JOB_CLUB_WORKER
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = /datum/job/vampire/primogen_toreador
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/club_worker
	config_tag = "CLUB_WORKER"
	display_order = JOB_DISPLAY_ORDER_STRIP
	exp_required_type_department = EXP_TYPE_CLUB
	department_for_prefs = /datum/job_department/strip_club
	departments_list = list(
		/datum/job_department/strip_club
	)

	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)

	description = "Offer strip club services. Some of your clientele may be... Unusual, but you are either addicted to vampire bites, or bribed to listen little and say even less."
	minimal_masquerade = 3
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_KIASYD)

/datum/outfit/job/club_worker
	name = "Stripper"
	jobtype = /datum/job/vampire/citizen
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/strip
	id = /obj/item/watch
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit=1)

/obj/effect/landmark/start/club_worker
	name = "Strip"
	icon_state = "Assistant"
