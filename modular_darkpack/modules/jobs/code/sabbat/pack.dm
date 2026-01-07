/datum/job/vampire/sabbatpack
	title = JOB_SABBAT_PACK
	faction = FACTION_CITY
	total_positions = 2
	spawn_positions = 2
	supervisors = "Caine"
	config_tag = "SABBAT_PACK"
	outfit = /datum/outfit/job/vampire/sabbatpack
	job_flags = CITY_JOB_FLAGS
	allowed_species = list(SPECIES_KINDRED)

	exp_required_type_department = EXP_TYPE_SABBAT
	department_for_prefs = /datum/job_department/sabbat
	departments_list = list(
		/datum/job_department/sabbat,
	)

	description = "You are a member of the Sabbat. You are charged with rebellion against the Elders and the Camarilla, against the Jyhad, against the Masquerade and the Traditions, and the recognition of Caine as the true Dark Father of all Kindred kind. NOTE: BY PLAYING THIS ROLE YOU AGREE TO AND HAVE READ THE SERVER'S RULES ON ESCALATION FOR ANTAGS. KEEP THINGS INTERESTING AND ENGAGING FOR BOTH SIDES. KILLING PLAYERS JUST BECAUSE YOU CAN MAY RESULT IN A ROLEBAN."
	minimal_masquerade = 0
	display_order = JOB_DISPLAY_ORDER_SABBATPACK
	whitelisted = TRUE

/datum/outfit/job/vampire/sabbatpack
	name = "Sabbat Pack"
	jobtype = /datum/job/vampire/sabbatpack
	l_pocket = /obj/item/smartphone
	r_pocket = /obj/item/vamp/keys/sabbat

/datum/outfit/job/vampire/sabbatpack/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.add_antag_datum(/datum/antagonist/sabbatist)

// keeping this for lateparty sabbat
/datum/antagonist/sabbatist
	name = "Sabbatist"
	roundend_category = "sabbattites"
	antagpanel_category = FACTION_SABBAT
	pref_flag = ROLE_REV
	antag_moodlet = /datum/mood_event/revolution
	antag_hud_name = "rev"

