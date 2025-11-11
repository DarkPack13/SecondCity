/datum/job/vampire/police_chief
	title = JOB_POLICE_CHIEF
	department_head = list("Police Department")
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = " the SFPD"
	config_tag = "POLICE_CHIEF"
	outfit = /datum/outfit/job/police_chief
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_POLICE_CHIEF
	exp_required_type_department = EXP_TYPE_POLICE
	department_for_prefs = /datum/job_department/police
	departments_list = list(
		/datum/job_department/police,
	)

	allowed_species = list(SPECIES_HUMAN)

	description = "Underpaid, overworked, and understrength. Do your best to keep the order in San Francisco. Keep the officers in line."
	minimal_masquerade = 0

/datum/outfit/job/police_chief
	name = "Police Chief"
	jobtype = /datum/job/vampire/police_chief

	//ears = /obj/item/p25radio/police/command
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police/chief
	//belt = /obj/item/storage/belt/holster/detective/vampire/officer
	gloves = /obj/item/watch
	id = /obj/item/card/police/chief
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/police/secure/chief
	backpack_contents = list(/obj/item/passport=1, /obj/item/card/credit=1, /obj/item/ammo_box/darkpack/c9mm = 1, /obj/item/restraints/handcuffs = 1, /obj/item/melee/baton/vamp = 1, /obj/item/storage/medkit/darkpack/ifak = 1)

/datum/outfit/job/police_chief/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/datum/martial_art/martial_art = new /datum/martial_art/cqc
	H.ignores_warrant = TRUE
	martial_art.teach(H)
