/datum/job/vampire/axe_gang
	title = "Axe Gang"
	faction = FACTION_CITY
	total_positions = 8
	spawn_positions = 8
	supervisors = "the other Axes"
	config_tag = "AXE_GANG"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/axe_gangster

	display_order = JOB_DISPLAY_ORDER_AXE_GANGSTER
	exp_required_type_department = EXP_TYPE_GANG
	department_for_prefs = /datum/job_department/axe_gang
	departments_list = list(
		/datum/job_department/axe_gang,
	)

	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)
	allowed_clans = list(VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_NAGARAJA)

	description = "You are a member of a Scarlet Screen known as the Axe Gang. Your leaders, the Screentenders, provide a place for outcasts like yourself to find fulfillment, and comradery. Sell weapons using your Warehouse, do drugs, commit crime, and protect your own."
	minimal_masquerade = 0

/datum/outfit/job/axe_gangster/pre_equip(mob/living/carbon/human/H)
	..()
	//H.grant_language(/datum/language/cantonese)

/datum/outfit/job/axe_gangster
	name = "Axe Gangster"
	jobtype = /datum/job/vampire/axe_gang
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/supplytech
	//l_pocket = /obj/item/vamp/phone/axe_gangster
	r_pocket = /obj/item/vamp/keys/axes
	backpack_contents = list(/obj/item/vamp/keys/supply, /obj/item/flashlight=1, /obj/item/passport=1, /obj/item/card/credit=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/knife/vamp)

/obj/effect/landmark/start/axe_gang
	name = "Axe Gang"
	icon_state = "Bouncer"
