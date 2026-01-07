/datum/job/vampire/priest
	title = JOB_PRIEST
	faction = FACTION_CITY
	total_positions = 2
	spawn_positions = 2
	supervisors = "God"
	config_tag = "PRIEST"
	outfit = /datum/outfit/job/vampire/priest
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_PRIEST
	exp_required_type_department = EXP_TYPE_CHURCH
	department_for_prefs = /datum/job_department/church
	departments_list = list(
		/datum/job_department/church,
	)
	allowed_species = list(SPECIES_HUMAN)
	description = "Be the shepherd of the flock in " + CITY_NAME + ", lead them to salvation, piety and righteousness."

/datum/outfit/job/vampire/priest
	name = "Priest"
	jobtype = /datum/job/vampire/priest

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/hunter
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/church
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/card/credit=1)
