/datum/job/vampire/sabbatductus
	title = JOB_SABBAT_DUCTUS
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "Caine"
	config_tag = "SABBAT_DUCTUS"
	outfit = /datum/outfit/job/vampire/sabbatductus
	allowed_species = list(SPECIES_KINDRED)
	job_flags = CITY_JOB_FLAGS
	exp_required_type_department = EXP_TYPE_SABBAT
	department_for_prefs = /datum/job_department/sabbat
	departments_list = list(
		/datum/job_department/sabbat,
	)

	description = "You are a Ductus and Pack Leader of your Sabbat pack. You are charged with rebellion against the Elders and the Camarilla, against the Jyhad, against the Masquerade and the Traditions, and the recognition of Caine as the true Dark Father of all Kindred kind. NOTE: BY PLAYING THIS ROLE YOU AGREE TO AND HAVE READ THE SERVER'S RULES ON ESCALATION FOR ANTAGS. KEEP THINGS INTERESTING AND ENGAGING FOR BOTH SIDES. KILLING PLAYERS JUST BECAUSE YOU CAN MAY RESULT IN A ROLEBAN."
	minimal_masquerade = 0
	display_order = JOB_DISPLAY_ORDER_SABBATDUCTUS
	whitelisted = TRUE

/datum/outfit/job/vampire/sabbatductus
	name = "Sabbat Ductus"
	jobtype = /datum/job/vampire/sabbatductus
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/sabbat

/datum/outfit/job/vampire/sabbatductus/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.add_antag_datum(/datum/antagonist/sabbatist)
