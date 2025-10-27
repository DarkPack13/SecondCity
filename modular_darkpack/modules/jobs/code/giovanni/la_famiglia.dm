
/datum/job/vampire/squadra
	title = JOB_LA_FAMIGLIA
	department_head = /datum/job/vampire/capo
	faction = FACTION_CITY
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Family"

	outfit = /datum/outfit/job/squadra

	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI
	department_for_prefs = /datum/job_department/giovanni
	departments_list = list(
		/datum/job_department/giovanni,
	)

	allowed_species = list(SPECIES_GHOUL, SPECIES_HUMAN)
	description = "Your family is a strange one. Maybe you are strange too, because sitting next to your great uncles as an equal is something you are greatly interested in."
	minimal_masquerade = 0

/datum/outfit/job/squadra
	name = "La Famiglia"
	jobtype = /datum/job/vampire/squadra
	id = /obj/item/watch
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit=1)

/obj/effect/landmark/start/squadra
	name = "La Famiglia"
