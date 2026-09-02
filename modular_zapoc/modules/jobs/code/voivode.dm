/datum/job/vampire/voivodate_citizen
	title = JOB_VOIVODATE_CITIZEN
	faction = FACTION_SABBAT
	total_positions = 5
	spawn_positions = 5
	supervisors = " the Laws of Hospitality"
	config_tag = "VOIVODATE_CITIZEN"
	outfit = /datum/outfit/job/vampire/voivodate_citizen
	job_flags = CITY_JOB_FLAGS

	display_order = JOB_DISPLAY_ORDER_VOIVODATE_CITIZEN
	exp_required_type_department = EXP_TYPE_MANOR
	departments_list = list(
		/datum/job_department/manor,
	)

	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL)
	allowed_clans = list(VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_OLD_CLAN_TZIMISCE, VAMPIRE_CLAN_HEALER_SALUBRI, VAMPIRE_CLAN_WARRIOR_SALUBRI, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY)

	description = "You belong to the Seer's Voivodate, a resurgance of the pre-existing California Voivodate. Above all you must respect the Hospitality, and the Voivodes."

	known_contacts = list(
		JOB_VOIVODE,
		JOB_BOGATYR_CAPTAIN,
		JOB_BOGATYR,
		JOB_ZADRUGA
	)

/datum/outfit/job/vampire/voivodate_citizen
	name = JOB_VOIVODATE_CITIZEN
	jobtype = /datum/job/vampire/voivodate_citizen
	uniform = /obj/item/clothing/under/vampire/punk
	suit = /obj/item/clothing/suit/vampire/trench/voivode
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/smartphone/voivodate_citizen
	backpack_contents = list(/obj/item/vamp/keys/voivodate = 1, /obj/item/passport = 1, /obj/item/flashlight = 1, /obj/item/card/credit/elder = 1)

/obj/item/smartphone/voivodate_citizen
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TZMISCE_NETWORK, OUR_ROLE = "Citizen of the Manor", USE_JOB_TITLE = FALSE)
		)


/datum/job/vampire/bogatyr/captain
	title = "Bogatyr Captain"
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/vampire/bogatyr/captain
	config_tag = "BOGATYR_CAPTAIN"
	description = "Captain of the Bogatyri, protectors of the Seer's Voivodate. You lead them in the protection of your family and the Voivode-in-Waiting who sleeps in the basement. Serve the Voivodes, and enforce the Hospitality on your family's lands."

	display_order = JOB_DISPLAY_ORDER_BOGATYR_CAPTAIN

	known_contacts = list(
		JOB_PRINCE,
		JOB_BARON,
		JOB_SHERIFF,
		JOB_EMISSARY,
		JOB_SENESCHAL,
		JOB_VOIVODE,
		JOB_BOGATYR,
		JOB_ZADRUGA,
		JOB_VOIVODATE_CITIZEN,
	)

/datum/outfit/job/vampire/bogatyr/captain
	name = "Bogatyr Captain"
	jobtype = /datum/job/vampire/bogatyr/captain
	// id = /obj/item/card/id/bogatyr/captain
