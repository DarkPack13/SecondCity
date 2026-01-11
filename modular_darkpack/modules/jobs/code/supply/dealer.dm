/datum/job/vampire/dealer
	title = "Dealer"
	faction = FACTION_CITY
	total_positions = 2
	spawn_positions = 2
	supervisors = "nobody. You are beholden only to yourself."
	config_tag = "DEALER"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/dealer

	display_order = JOB_DISPLAY_ORDER_DEALER
	exp_required_type_department = EXP_TYPE_WAREHOUSE
	department_for_prefs = /datum/job_department/supply
	departments_list = list(
		/datum/job_department/supply,
	)

	known_contacts = list("Prince", "Seneschal", "Sheriff", "Baron")
	allowed_species = list(SPECIES_HUMAN)
	species_slots = list(SPECIES_HUMAN = 1)

	description = "You provide both legal and illegal supplies to those that get busy during the night. You are your own person yet you know people are out for you. Time to buckle in..."
	minimal_masquerade = 0

/datum/outfit/job/vampire/dealer
	name = "Dealer"
	jobtype = /datum/job/vampire/dealer
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/dealer
	l_pocket = /obj/item/smartphone/dealer
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/card/credit/rich=1, /obj/item/hatchet)
