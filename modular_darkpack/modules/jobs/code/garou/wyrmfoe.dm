/datum/job/vampire/wyrmfoe
	title = JOB_GAROU_WYRMFOE
//	description = "You are the top dog of this city. You hold Praxis over " + CITY_NAME + ", and your word is law. Make sure the Masquerade is upheld, and your status is respected."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = /datum/job/vampire/councillor
	faction = FACTION_GAIA
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_LITANY
	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 100
	exp_required_type = EXP_TYPE_GAIA
	exp_required_type_department = EXP_TYPE_GAIA
	exp_granted_type = EXP_TYPE_GAIA
	config_tag = "WYRMFOE"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/wyrmfoe

	display_order = JOB_DISPLAY_ORDER_WYRMFOE
	department_for_prefs = /datum/job_department/gaia
	departments_list = list(
		/datum/job_department/gaia,
	)

	allowed_species = list(SPECIES_GAROU)

	known_contacts = list(
		"Councillor",
		"Truthcatcher",
		"Wyrmfoe",
		"Guardian"
	)

/datum/outfit/job/wyrmfoe
	name = "Sept Wyrmfoe"
	jobtype = /datum/job/vamp/garou/amberglade/keeper

	id = /obj/item/card/park_ranger/biologist
	uniform =  /obj/item/clothing/under/vampire/mechanic
	suit = /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/work
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit/rich=1)
