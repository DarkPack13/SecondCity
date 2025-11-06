/datum/job/vampire/axe_leader
	title = "Screentender"
	faction = FACTION_CITY
	total_positions = 2
	spawn_positions = 2
	supervisors = "nobody. You are beholden only to yourself."
	config_tag = "AXE_GANG_LEADER"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/axe_leader

	display_order = JOB_DISPLAY_ORDER_AXE_LEADER
	exp_required_type_department = EXP_TYPE_GANG
	department_for_prefs = /datum/job_department/axe_gang
	departments_list = list(
		/datum/job_department/axe_gang,
	)

	known_contacts = list("Prince", "Seneschal", "Sheriff", "Baron")
	allowed_species = list(SPECIES_HUMAN)
	species_slots = list(SPECIES_HUMAN = 1)

	description = "You lead a particular group, known as the Axe Gang, with the assistance of an enigmatic partner. You may understand the true identity of your co-conspirators, or not. Either way, they respect the position your co-leader and you hold."
	minimal_masquerade = 0

/datum/outfit/job/axe_leader/pre_equip(mob/living/carbon/human/H)
	..()
	//H.grant_language(/datum/language/cantonese)

/datum/outfit/job/axe_leader
	name = "Screentender"
	jobtype = /datum/job/vampire/axe_leader
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/dealer
	//l_pocket = /obj/item/vamp/phone/axe_leader
	r_pocket = /obj/item/vamp/keys/axes
	backpack_contents = list(/obj/item/vamp/keys/supply, /obj/item/flashlight=1, /obj/item/watch=1, /obj/item/passport=1, /obj/item/card/credit/rich=1, /obj/item/hatchet)

/obj/effect/landmark/start/axe_leader
	name = "Screentender"
	icon_state = "Dealer"
