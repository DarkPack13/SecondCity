/datum/job/vampire/capo
	title = JOB_CAPO
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Family and the Traditions"
	config_tag = "CAPO"
	outfit = /datum/outfit/job/vampire/capo
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI
	department_for_prefs = /datum/job_department/giovanni
	departments_list = list(
		/datum/job_department/giovanni,
	)

	description = "Pure blood runs through your veins and, with it, old power. Throughout your long life you have learnt to hold onto two things and never let go: money, and family."
	minimal_masquerade = 0
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_CAPPADOCIAN)

/datum/outfit/job/vampire/capo
	name = "Capo"
	jobtype = /datum/job/vampire/capo

	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/smartphone/giovanni_capo
	r_pocket = /obj/item/vamp/keys/capo
	backpack_contents = list(/obj/item/card/credit/giovanniboss=1)
