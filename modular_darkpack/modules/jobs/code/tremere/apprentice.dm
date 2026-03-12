/datum/job/vampire/apprentice
	title = JOB_CHANTRY_APPRENTICE
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = SUPERVISOR_REGENT
	config_tag = "CHANTRY_APPRENTICE"
	outfit = /datum/outfit/job/vampire/apprentice
	job_flags = CITY_JOB_FLAGS
	exp_required_type_department = EXP_TYPE_CHANTRY
	department_for_prefs = /datum/job_department/chantry
	departments_list = list(
		/datum/job_department/chantry,
	)
	display_order = JOB_DISPLAY_ORDER_APPRENTICE

	description = "Keep a census of events and provide information to neonates. Listen to the Regent Carefully. Study blood magic and protect the chantry."
	minimal_masquerade = 3
	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TREMERE)
	known_contacts = list("Tremere Regent")

	alt_titles = list(
		"Chantry Acolyte",
		"Chantry Magister"
	)

/datum/outfit/job/vampire/apprentice
	name = "Apprentice"
	jobtype = /datum/job/vampire/apprentice

	id = /obj/item/card/archive
	glasses = /obj/item/clothing/glasses/vampire/perception
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform = /obj/item/clothing/under/vampire/archivist
	r_pocket = /obj/item/vamp/keys/archive
	l_pocket = /obj/item/smartphone/tremere_apprentice
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(/obj/item/ritual_tome/arcane=1, /obj/item/card/credit=1, /obj/item/scythe/vamp=1)
