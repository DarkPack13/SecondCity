
/datum/job/vampire/bogatyr
	title = JOB_BOGATYR
	faction = FACTION_SABBAT
	total_positions = 2 // APOC EDIT CHANGE - JOBS - (Voivode)
	spawn_positions = 2 // APOC EDIT CHANGE - JOBS - (Voivode)
	supervisors = " the Laws of Hospitality"
	config_tag = "BOGATYR"
	outfit = /datum/outfit/job/vampire/bogatyr
	job_flags = CITY_JOB_FLAGS
	exp_required_type_department = EXP_TYPE_MANOR
	departments_list = list(
		/datum/job_department/manor,
	)
	display_order = JOB_DISPLAY_ORDER_BOGATYR

	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_OLD_CLAN_TZIMISCE) // APOC EDIT CHANGE - JOBS - (Voivode)

	description = "You bare the name of the warriors that guarded ancient Dragons, to be a Bogatyr is to serve the Voivodes and the Seer Voivodate. Protect your family and the Sarcophagus of the Voivode-in-Waiting." // APOC EDIT CHANGE - JOBS - (Voivode)
	maximal_generation = 9
	maximum_immortal_age = 200
	minimum_masquerade = 2

	known_contacts = list(
		JOB_PRINCE,
		JOB_BARON,
		JOB_SHERIFF,
		JOB_VOIVODE,
		JOB_ZADRUGA
	)

/datum/outfit/job/vampire/bogatyr
	name = JOB_BOGATYR
	jobtype = /datum/job/vampire/bogatyr
	id = /obj/item/card/bogatyr
	glasses = /obj/item/clothing/glasses/vampire/yellow
	uniform = /obj/item/clothing/under/vampire/bogatyr
	suit = /obj/item/clothing/suit/vampire/jacket/punk
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/bogatyr
	suit = /obj/item/clothing/suit/vampire/bogatyr
	belt = /obj/item/storage/belt/sheath/vamp/sword
	l_pocket = /obj/item/smartphone/bogatyr
	backpack_contents = list(/obj/item/vamp/keys/voivodate = 1, /obj/item/card/credit=1) // DARKPACK EDIT CHANGE - JOBS - (Voivode)
