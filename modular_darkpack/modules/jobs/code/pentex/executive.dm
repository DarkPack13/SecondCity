/datum/job/vampire/executive
	title = JOB_PENTEX_EXEC
	description = "You are an acting executive for " + MAIN_EVIL_COMPANY + " operating out of San Francisco. With discretion to the Branch Leader, a position you may aim for, your job is to fuel production and expand operations."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list(MAIN_EVIL_COMPANY)
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Board and the Branch Lead"
	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 150
	exp_required_type = EXP_TYPE_SPIRAL
	exp_required_type_department = EXP_TYPE_SPIRAL
	exp_granted_type = EXP_TYPE_SPIRAL
	config_tag = "EXECUTIVE"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/executive

	allowed_species = list(SPECIES_GAROU)
//	allowed_tribes = list(TRIBE_WYRM, TRIBE_RONIN)

	display_order = JOB_DISPLAY_ORDER_executive
	department_for_prefs = /datum/job_department/pentex
	departments_list = list(
		/datum/job_department/pentex,
	)

	known_contacts = list(
		JOB_PENTEX_LEAD,
		JOB_PENTEX_AFFAIRS,
		JOB_PENTEX_SEC_CHIEF
	)

//	minimal_renownrank = 3
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	minimal_masquerade = 5
	allowed_species = list(SPECIES_GAROU, SPECIES_KINDRED, SPECIES_HUMAN)
//	allowed_tribes = list("Black Spiral Dancers", "Ronin")
	allowed_clans = VAMPIRE_CLAN_ALL


/datum/outfit/job/executive
	name = JOB_PENTEX_EXEC
	jobtype = /datum/job/vampire/executive

//	ears = /obj/item/p25radio
	id = /obj/item/card/pentex/executive
	uniform =  /obj/item/clothing/under/vampire/pentex_executive_suit
	shoes = /obj/item/clothing/shoes/vampire/businessblack
	l_pocket = /obj/item/smartphone // /pentex_exec - todo: subtype
	r_pocket = /obj/item/vamp/keys/pentex
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/card/credit/seneschal=1)

/datum/outfit/job/executive/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/pentex_executiveskirt
		shoes = /obj/item/clothing/shoes/vampire/heels
