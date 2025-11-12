/datum/job/vampire/taxi
	title = JOB_TAXI_DRIVER
	department_head = list("Justicar")
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_TRADITIONS
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/taxi
	config_tag = "TAXI_DRIVER"
	display_order = JOB_DISPLAY_ORDER_TAXI
	exp_required_type_department = EXP_TYPE_SERVICES
	department_for_prefs = /datum/job_department/city_services
	departments_list = list(
		/datum/job_department/city_services,
	)
	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)

	description = "Drive people in the city."
	minimal_masquerade = 0

	allowed_clans = list(VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_CAPPADOCIAN)

/datum/outfit/job/taxi
	name = "Taxi Driver"
	jobtype = /datum/job/vampire/taxi

	id = /obj/item/watch
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/taxi
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit=1, /obj/item/melee/vamp/tire=1)

/obj/effect/landmark/start/taxi
	name = "Taxi Driver"
