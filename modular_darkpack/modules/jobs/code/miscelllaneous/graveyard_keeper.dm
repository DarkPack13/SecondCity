/datum/job/vampire/graveyard
	title = JOB_GRAVEYARD_KEEPER
	department_head = /datum/job/vampire/prince
	faction = FACTION_CITY
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Camarilla or the Anarchs"
	exp_required_type_department = EXP_TYPE_SERVICES
	config_tag = "GRAVEYARD_KEEPER"
	outfit = /datum/outfit/job/vampire/graveyard
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_GRAVEYARD
	department_for_prefs = /datum/job_department/city_services
	departments_list = list(
		/datum/job_department/city_services,
	)
	description = "A vile curse has gripped the dead of this city. You must keep the graveyard clean and the Masquerade intact."
	minimal_masquerade = 0
	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL)
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_CAPPADOCIAN)

/datum/outfit/job/vampire/graveyard
	name = "Graveyard Keeper"
	jobtype = /datum/job/vampire/graveyard

	id = /obj/item/card/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/vampire/graveyard
	suit = /obj/item/clothing/suit/vampire/trench
	glasses = /obj/item/clothing/glasses/vampire/yellow
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/graveyard
	r_hand = /obj/item/shovel/vamp
	backpack_contents = list(/obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/card/credit=1, /obj/item/scythe/vamp=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/graveyardkeeper
	name = "Graveyard Keeper"
	icon_state = "Graveyard Keeper"
