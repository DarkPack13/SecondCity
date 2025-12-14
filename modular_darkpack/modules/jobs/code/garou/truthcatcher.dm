/datum/job/vampire/truthcatcher
	title = JOB_GAROU_TRUTHCATCHER
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
	config_tag = "TRUTHCATCHER"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/trutchcatcher

	display_order = JOB_DISPLAY_ORDER_TRUTHCATCHER
	department_for_prefs = /datum/job_department/gaia
	departments_list = list(
		/datum/job_department/gaia,
	)

//	allowed_species = list(SPECIES_GAROU)

	known_contacts = list(
		"Councillor",
		"Warder",
		"Wyrmfoe",
		"Guardian"
	)

/datum/outfit/job/vampire/trutchcatcher
	name = "Sept Truthcatcher"
	jobtype = /datum/job/vampire/truthcatcher

	id = /obj/item/card/park_ranger/guide
	uniform =  /obj/item/clothing/under/vampire/office
	suit = /obj/item/clothing/suit/vampire/coat/winter/alt
	gloves = /obj/item/clothing/gloves/vampire/work
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	l_pocket = /obj/item/smartphone
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/veil_contract, /obj/item/card/credit/rich=1)

