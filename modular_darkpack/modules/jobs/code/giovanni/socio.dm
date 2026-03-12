/datum/job/vampire/socio
	title = JOB_SOCIO
	faction = FACTION_CITY
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Family or your Spouse"
	config_tag = "SOCIO"
	outfit = /datum/outfit/job/vampire/socio
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI
	department_for_prefs = /datum/job_department/giovanni
	departments_list = list(
		/datum/job_department/giovanni,
	)

	allowed_splats = list(SPLAT_GHOUL, SPLAT_NONE, SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_CAITIFF)
	description = "Your family is a strange one. Maybe you are strange too, because sitting next to your great uncles as an equal is something you are greatly interested in."
	minimal_masquerade = 0

	alt_titles = list(
		"Socia"
	)

/datum/outfit/job/vampire/socio
	name = "Socio"
	jobtype = /datum/job/vampire/socio
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/smartphone/giovanni_socio
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/card/credit=1)
