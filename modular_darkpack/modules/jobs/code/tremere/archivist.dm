
/datum/job/vampire/archivist
	title = JOB_CHANTRY_ARCHIVIST
	department_head = list("Prince")
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Traditions and the Regent"


	outfit = /datum/outfit/job/archivist





	exp_required_type_department = EXP_TYPE_TREMERE

	display_order = JOB_DISPLAY_ORDER_ARCHIVIST

	description = "Keep a census of events and provide information to neonates. Listen to the Regent Carefully. Study blood magic and protect the chantry."
	minimal_masquerade = 3
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_GARGOYLE)
	known_contacts = list("Tremere Regent")

/datum/outfit/job/archivist
	name = "Archivist"
	jobtype = /datum/job/vampire/archivist

	id = /obj/item/card/archive
	glasses = /obj/item/clothing/glasses/vampire/perception
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform = /obj/item/clothing/under/vampire/archivist
	r_pocket = /obj/item/vamp/keys/archive
	l_pocket = /obj/item/vamp/phone/archivist
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/arcane_tome=1, /obj/item/card/credit=1, /obj/item/scythe/vamp=1)

/datum/outfit/job/archivist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/archivist/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/archivist
	name = "Archivist"
	icon_state = "Archivist"
