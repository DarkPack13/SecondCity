/datum/job/vampire/harpy
	title =  JOB_HARPY
	description = "You are an expert on the nightlife of Cainite society. Acting as one of the chief advisors on all things related to boons and diplomacy, the Prince defers quite the amount of judgement to you. Don't squander it."
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = /datum/job/vampire/prince
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_PRINCE
	config_tag = "HARPY"
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CAMARILLA
	exp_required_type_department = EXP_TYPE_CAMARILLA
	exp_granted_type = EXP_TYPE_CAMARILLA
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/harpy

	display_order = JOB_DISPLAY_ORDER_HARPY
	department_for_prefs = /datum/job_department/camarilla
	departments_list = list(
		/datum/job_department/camarilla,
	)

	minimal_generation = 12	//Uncomment when players get exp enough
	minimal_masquerade = 5

	allowed_species = list(SPECIES_KINDRED)

	known_contacts = list("Prince","Sheriff","Tremere Regent","Dealer","Emissary","Baron","Primogens")

	allowed_bloodlines = list(CLAN_DAUGHTERS_OF_CACOPHONY, CLAN_TRUE_BRUJAH, CLAN_BRUJAH, CLAN_TREMERE, CLAN_VENTRUE, CLAN_NOSFERATU, CLAN_GANGREL, CLAN_TOREADOR, CLAN_MALKAVIAN, CLAN_BANU_HAQIM, CLAN_TZIMISCE, CLAN_SETITES, CLAN_LASOMBRA, CLAN_GARGOYLE, CLAN_KIASYD)

/datum/outfit/job/harpy
	name = "Harpy"
	jobtype = /datum/job/vampire/harpy

	ears = /obj/item/p25radio
	id = /obj/item/card/clerk/harpy
	uniform = /obj/item/clothing/under/vampire/clerk
	shoes = /obj/item/clothing/shoes/vampire/brown
//	l_pocket = /obj/item/vamp/phone/harpy
	r_pocket = /obj/item/vamp/keys/clerk
//	backpack_contents = list(/obj/item/passport=1, /obj/item/phone_book=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/seneschal=1)

/obj/effect/landmark/start/harpy
	name = "Harpy"
	icon_state = "Clerk"
