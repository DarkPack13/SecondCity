
/datum/job/vampire/regent
	title = JOB_CHANTRY_REGENT
	department_head = list("Prince")
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Pyramid"


	outfit = /datum/outfit/job/regent





	exp_required_type_department = EXP_TYPE_TREMERE


	display_order = JOB_DISPLAY_ORDER_REGENT
	description = "Lead the Chantry. You serve as both the Regent and Tremere Primogen. You report to the Tremere Lord of this region first, Prince second."
	minimal_masquerade = 4
	minimal_generation = 10
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TREMERE)

	known_contacts = list("Prince")

/datum/outfit/job/regent
	name = "Chantry Regent"
	jobtype = /datum/job/vampire/regent

	id = /obj/item/card/regent
	glasses = /obj/item/clothing/glasses/vampire/perception
	suit = /obj/item/clothing/suit/vampire/trench/archive
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform = /obj/item/clothing/under/vampire/archivist
	r_pocket = /obj/item/vamp/keys/regent
	l_pocket = /obj/item/vamp/phone/tremere
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(/obj/item/passport=1, /obj/item/phone_book=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/arcane_tome=1, /obj/item/card/credit/elder=1, /obj/item/scythe/vamp=1)

/datum/outfit/job/regent/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/archivist/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/regent
	name = "Chantry Regent"
	icon_state = "Archivist"
