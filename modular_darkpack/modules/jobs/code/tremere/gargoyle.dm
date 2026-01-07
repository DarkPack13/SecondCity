/datum/job/vampire/gargoyle
	title = JOB_CHANTRY_GARGOYLE
	faction = FACTION_CITY
	total_positions = 5
	spawn_positions = 5
	supervisors = SUPERVISOR_REGENT
	config_tag = "CHANTRY_GARGOYLE"
	outfit = /datum/outfit/job/vampire/gargoyle
	job_flags = CITY_JOB_FLAGS
	exp_required_type_department = EXP_TYPE_CHANTRY
	department_for_prefs = /datum/job_department/chantry
	departments_list = list(
		/datum/job_department/chantry,
	)
	display_order = JOB_DISPLAY_ORDER_GARGOYLE

	description = "An agent of the Chantry, you are a Tremere Gargoyle who was made legally having existed before their creation was banned. Serve the Regent well!"
	minimal_masquerade = 3
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_GARGOYLE)
	known_contacts = list("Tremere Regent")

/datum/outfit/job/vampire/gargoyle
	name = "Chantry Gargoyle"
	jobtype = /datum/job/vampire/gargoyle

	id = /obj/item/card/archive
	glasses = /obj/item/clothing/glasses/vampire/red
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/work
	uniform = /obj/item/clothing/under/vampire/turtleneck_black
	suit = /obj/item/clothing/suit/hooded/robes/tremere
	mask = /obj/item/clothing/mask/vampire/venetian_mask
	r_pocket = /obj/item/vamp/keys/archive
	l_pocket = /obj/item/smartphone/gargoyle
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(
		/obj/item/ritual_tome/arcane = 1,
		/obj/item/card/credit = 1,
		/obj/item/scythe/vamp = 1,
	)
