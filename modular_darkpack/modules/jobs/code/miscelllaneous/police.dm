
/datum/job/vampire/police_officer
	title = JOB_POLICE_OFFICER
	department_head = list("Police Department")
	faction = FACTION_CITY
	total_positions = 5
	spawn_positions = 5
	supervisors = " the SFPD Chief and your Sergeant."


	outfit = /datum/outfit/job/police_officer





	display_order = JOB_DISPLAY_ORDER_POLICE
	exp_required_type_department = EXP_TYPE_POLICE

	allowed_species = list(SPECIES_GHOUL, SPECIES_HUMAN)
	species_slots = list(SPECIES_GHOUL = 2)

	description = "Enforce the Law."
	minimal_masquerade = 0

	known_contacts = list("Police Chief")

/datum/outfit/job/police_officer
	name = "Police Officer"
	jobtype = /datum/job/vampire/police_officer

	ears = /obj/item/p25radio/police
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police
	belt = /obj/item/storage/belt/holster/detective/vampire/police
	gloves = /obj/item/watch
	id = /obj/item/card/police
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/police
	backpack_contents = list(/obj/item/passport=1, /obj/item/card/credit=1, /obj/item/ammo_box/vampire/c9mm = 1, /obj/item/restraints/handcuffs = 1, /obj/item/melee/baton/vamp = 1, /obj/item/storage/medkit/darkpack/ifak = 1)

/datum/job/vampire/police_sergeant
	title = JOB_POLICE_SERGEANT
	department_head = list("Police Department")
	faction = FACTION_CITY
	total_positions = 2
	spawn_positions = 2
	supervisors = " the SFPD Chief"


	outfit = /datum/outfit/job/police_sergeant





	display_order = JOB_DISPLAY_ORDER_POLICE_SERGEANT
	exp_required_type_department = EXP_TYPE_POLICE

	allowed_species = list(SPECIES_HUMAN)

	description = "Enforce the law. Keep the officers in line. Follow what the Chief says."
	minimal_masquerade = 0

	known_contacts = list("Police Chief")

/datum/outfit/job/police_sergeant
	name = "Police Sergeant"
	jobtype = /datum/job/vampire/police_sergeant

	ears = /obj/item/p25radio/police/supervisor
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police/sergeant
	belt = /obj/item/storage/belt/holster/detective/vampire/officer
	gloves = /obj/item/watch
	id = /obj/item/card/police/sergeant
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/police/secure
	backpack_contents = list(/obj/item/passport=1, /obj/item/card/credit=1, /obj/item/ammo_box/vampire/c9mm = 1, /obj/item/restraints/handcuffs = 1, /obj/item/melee/baton/vamp = 1, /obj/item/storage/medkit/darkpack/ifak = 1)

/datum/job/vampire/police_chief
	title = JOB_POLICE_CHIEF
	department_head = list("Police Department")
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = " the SFPD"


	outfit = /datum/outfit/job/police_chief





	display_order = JOB_DISPLAY_ORDER_POLICE_CHIEF
	exp_required_type_department = EXP_TYPE_POLICE

	allowed_species = list(SPECIES_HUMAN)

	description = "Underpaid, overworked, and understrength. Do your best to keep the order in San Francisco. Keep the officers in line."
	minimal_masquerade = 0

//	known_contacts = list("Investigator")

/datum/outfit/job/police_chief
	name = "Police Chief"
	jobtype = /datum/job/vampire/police_chief

	ears = /obj/item/p25radio/police/command
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police/chief
	belt = /obj/item/storage/belt/holster/detective/vampire/officer
	gloves = /obj/item/watch
	id = /obj/item/card/police/chief
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/police/secure/chief
	backpack_contents = list(/obj/item/passport=1, /obj/item/card/credit=1, /obj/item/ammo_box/vampire/c9mm = 1, /obj/item/restraints/handcuffs = 1, /obj/item/melee/baton/vamp = 1, /obj/item/storage/medkit/darkpack/ifak = 1)

/datum/outfit/job/police_officer/post_equip(mob/living/carbon/human/H)
	..()
	H.ignores_warrant = TRUE

/datum/outfit/job/police_chief/post_equip(mob/living/carbon/human/H)
	..()
	var/datum/martial_art/martial_art = new /datum/martial_art/cqc
	H.ignores_warrant = TRUE
	martial_art.teach(H)

/datum/outfit/job/police_sergeant/post_equip(mob/living/carbon/human/H)
	..()
	H.ignores_warrant = TRUE
