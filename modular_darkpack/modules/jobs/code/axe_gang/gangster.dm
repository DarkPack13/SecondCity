/datum/job/vamp/axe_gang
	title = "Axe Gang"
	faction = "Vampire"
	total_positions = 8
	spawn_positions = 8
	supervisors = "the other Axes"
	selection_color = "#bb9d3d"

	outfit = /datum/outfit/job/axe_gangster

	display_order = JOB_DISPLAY_ORDER_AXE_GANGSTER
	exp_required_type_department = EXP_TYPE_GANG

	allowed_species = list("Vampire", "Ghoul", "Human")
	allowed_bloodlines = list(CLAN_NONE, CLAN_GANGREL, CLAN_GARGOYLE, CLAN_DAUGHTERS_OF_CACOPHONY, CLAN_CAPPADOCIAN, CLAN_NAGARAJA,)


	duty = "Your gang answers to enigmatic leaders in Chinatown. In absence of their leadership, the Axes answer to nobody but themselves. Sell weapons using your Warehouse , do drugs, commit crime, and protect your own."
	v_duty = "You are a member of a Scarlet Screen known as the Axe Gang. Your leaders, the Screentenders, provide a place for outcasts like yourself to find fulfillment, and comradery. Sell weapons using your Warehouse , do drugs, commit crime, and protect your own."
	experience_addition = 10
	minimal_masquerade = 0

/datum/outfit/job/axe_gangster/pre_equip(mob/living/carbon/human/H)
	..()
	H.grant_language(/datum/language/cantonese)

/datum/outfit/job/axe_gangster
	name = "Axe Gangster"
	jobtype = /datum/job/vamp/axe_gang
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/supplytech
	l_pocket = /obj/item/vamp/phone/axe_gangster
	r_pocket = /obj/item/vamp/keys/axes
	backpack_contents = list(/obj/item/vamp/keys/supply, /obj/item/flashlight=1, /obj/item/passport=1, /obj/item/vamp/creditcard=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/vampire/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/melee/vampirearms/knife, /obj/item/hatchet)

/obj/effect/landmark/start/axe_gang
	name = "Axe Gang"
	icon_state = "bouncer"
