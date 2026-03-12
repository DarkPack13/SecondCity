/datum/job/vampire/soldato
	title = JOB_SOLDATO
	faction = FACTION_CITY
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Family and the Traditions"
	config_tag = "SOLDATO"
	outfit = /datum/outfit/job/vampire/soldato
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI
	department_for_prefs = /datum/job_department/giovanni
	departments_list = list(
		/datum/job_department/giovanni,
	)

	description = "Whether born or Embraced into the family, you are one of the Giovanni. Be you a necromancer, financier or lowly fledgling, remember that so long as you stand with your family, they too will stand with you."
	minimal_masquerade = 0
	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_GIOVANNI)

	alt_titles = list(
		"Soldata"
	)

/datum/outfit/job/vampire/soldato
	name = "Soldato"
	jobtype = /datum/job/vampire/soldato

	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/smartphone/giovanni_soldato
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/card/credit/rich=1, /obj/item/ritual_tome/necromancy=1)
