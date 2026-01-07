/datum/job/vampire/police_chief
	title = JOB_POLICE_CHIEF
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = " the SFPD"
	config_tag = "POLICE_CHIEF"
	outfit = /datum/outfit/job/vampire/police_chief
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_POLICE_CHIEF
	exp_required_type_department = EXP_TYPE_POLICE
	department_for_prefs = /datum/job_department/police
	departments_list = list(
		/datum/job_department/police,
	)

	allowed_species = list(SPECIES_HUMAN)

	description = "Underpaid, overworked, and understrength. Do your best to keep the order in " + CITY_NAME + ". Keep the officers in line."
	minimal_masquerade = 0

/datum/outfit/job/vampire/police_chief
	name = "Police Chief"
	jobtype = /datum/job/vampire/police_chief

	ears = /obj/item/radio/headset/darkpack/police
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police/chief
	belt = /obj/item/storage/belt/holster/detective/darkpack/officer
	id = /obj/item/card/police/chief
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/police/secure/chief
	backpack_contents = list(/obj/item/card/credit=1, /obj/item/ammo_box/darkpack/c9mm = 1, /obj/item/restraints/handcuffs = 1, /obj/item/melee/baton/vamp = 1, /obj/item/storage/medkit/darkpack/ifak = 1)

/datum/outfit/job/vampire/police_chief/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/datum/martial_art/martial_art = new /datum/martial_art/cqc
	H.ignores_warrant = TRUE
	martial_art.teach(H)
