/datum/job/vampire/doctor
	title = JOB_DOCTOR
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Camarilla or the Anarchs"
	exp_required_type_department = EXP_TYPE_CLINIC
	config_tag = "DOCTOR"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/clinic_doctor

	display_order = JOB_DISPLAY_ORDER_DOCTOR
	department_for_prefs = /datum/job_department/clinic
	departments_list = list(
		/datum/job_department/clinic,
	)

	description = "Help your fellow kindred in all matters medicine related. Sell blood. Keep your human colleagues ignorant."
	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)
	allowed_clans = list(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_KIASYD)
	known_contacts = list("Clinic Director")

/datum/outfit/job/vampire/clinic_doctor
	name = "Doctor"
	jobtype = /datum/job/vampire/doctor

	ears = /obj/item/radio/headset/darkpack
	id = /obj/item/card/clinic
	uniform = /obj/item/clothing/under/vampire/nurse
	shoes = /obj/item/clothing/shoes/vampire/white
	suit =  /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/latex
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/clinic
	backpack_contents = list(/obj/item/card/credit=1, /obj/item/storage/medkit/darkpack/doctor=1)

	skillchips = list(/obj/item/skillchip/entrails_reader)
