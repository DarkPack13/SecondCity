/datum/job/vampire/employee
	title = JOB_PENTEX_EMPLOYEE
	description = "You are an acting chief of security for the Endron Oil Refinery, operating out of San Francisco. With discretion to the Branch Leader, your job is to keep the complex and it's proprietary information with the help of your security team, and to turn over contract violators to internal affairs or the executives."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list(MAIN_EVIL_COMPANY)
	faction = FACTION_CITY
	total_positions = 5
	spawn_positions = 5
	supervisors = "the Board and the Branch Lead"
	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 50
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL
	config_tag = "PENTEX_EMPLOYEE"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/employee

	allowed_species = list(SPECIES_GAROU)
//	allowed_tribes = list(TRIBE_WYRM, TRIBE_RONIN)

	display_order = JOB_DISPLAY_ORDER_EMPLOYEE
	department_for_prefs = /datum/job_department/pentex
	departments_list = list(
		/datum/job_department/pentex,
	)

	known_contacts = list(
		JOB_PENTEX_LEAD,
		JOB_PENTEX_EXEC,
		JOB_PENTEX_AFFAIRS
	)

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	minimal_masquerade = 3
	allowed_species = list(SPECIES_GAROU, SPECIES_KINDRED, SPECIES_HUMAN)
//	allowed_tribes = list("Black Spiral Dancers", "Ronin")
	allowed_clans = VAMPIRE_CLAN_ALL

/datum/outfit/job/employee
	name = JOB_PENTEX_EMPLOYEE
	jobtype = /datum/job/vampire/employee

//	ears = /obj/item/p25radio
	id = /obj/item/card/pentex
	uniform = /obj/item/clothing/under/vampire/pentex_longleeve
	gloves = /obj/item/clothing/gloves/vampire/work
	shoes = /obj/item/clothing/shoes/vampire
	r_pocket = /obj/item/vamp/keys/pentex
	l_pocket = /obj/item/smartphone // /employee - todo subtype
	backpack_contents = list(/obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/card/credit=1)
