/datum/job/vampire/acolyte
	title = JOB_CHANTRY_ACOLYTE
	faction = FACTION_CAMARILLA
	total_positions = 4
	spawn_positions = 4
	supervisors = SUPERVISOR_REGENT
	config_tag = "CHANTRY_ACOLYTE"
	outfit = /datum/outfit/job/vampire/acolyte
	job_flags = CITY_JOB_FLAGS
	exp_required_type_department = EXP_TYPE_CHANTRY
	department_for_prefs = /datum/job_department/chantry
	departments_list = list(
		/datum/job_department/chantry,
	)
	display_order = JOB_DISPLAY_ORDER_ACOLYTE

	description = "As an Acolyte of the Pyramid, you are unbonded, or unembraced, to the Clan Tremere via the Transubstantiation of the Seven, the ritual which binds all Tremere to the Council of Seven. You are likely a gargoyle, ghoul, or some type of servant to the Tremere, serving with loyalty to the Clan, or with the ambition to advance into the good graces of the Warlocks, with all the rewards that come with it."
	minimal_masquerade = 3
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL)
	splat_slots = list(SPLAT_GHOUL = 2, SPLAT_KINDRED = 2)
	allowed_clans = list(VAMPIRE_CLAN_GARGOYLE)
	known_contacts = list("Tremere Regent")

/datum/outfit/job/vampire/acolyte
	name = "Chantry Acolyte"
	jobtype = /datum/job/vampire/acolyte
	id = /obj/item/card/archive
	glasses = /obj/item/clothing/glasses/vampire/perception
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/work
	uniform = /obj/item/clothing/under/vampire/turtleneck_black
	suit = /obj/item/clothing/suit/hooded/robes/tremere
	belt = /obj/item/scythe/vamp
	r_pocket = /obj/item/vamp/keys/archive
	l_pocket = /obj/item/smartphone/acolyte
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(
		// /obj/item/ritual_tome/arcane = 1, acolytes, typically being ghouls or gargoyles, do not study thaumaturgy, uncomment if not going fully lore accurate
		/obj/item/card/credit = 1,
	)
