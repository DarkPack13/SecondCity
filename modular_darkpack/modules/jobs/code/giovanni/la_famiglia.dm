/datum/job/vampire/famiglia
	title = JOB_LA_FAMIGLIA
	faction = FACTION_CITY
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Family or your Spouse"
	config_tag = "LA_FAMIGLIA"
	outfit = /datum/outfit/job/vampire/famiglia
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI
	department_for_prefs = /datum/job_department/giovanni
	departments_list = list(
		/datum/job_department/giovanni,
	)

	allowed_species = list(SPECIES_GHOUL, SPECIES_HUMAN, SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_LASOMBRA)
	description = "Your family is a strange one. Maybe you are strange too, because sitting next to your great uncles as an equal is something you are greatly interested in."
	minimal_masquerade = 0

/datum/outfit/job/vampire/famiglia
	name = "La Famiglia"
	jobtype = /datum/job/vampire/famiglia
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/smartphone/giovanni_famiglia
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/card/credit=1)
