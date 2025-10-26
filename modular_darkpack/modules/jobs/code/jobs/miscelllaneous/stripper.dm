
/datum/job/vampire/strip
	title = "Stripper"
	faction = "Vampire"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#e3e3e3"
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/strip
	antag_rep = 7
	paycheck = PAYCHECK_ASSISTANT // Get a job. Job reassignment changes your paycheck now. Get over it.
	exp_type_department = EXP_TYPE_SERVICES

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_STRIP
	allowed_species = list("Vampire", "Ghoul", "Human", "Werewolf", "Kuei-Jin")

	v_duty = "Offer strip club services to humans, undead or anything else that walks through the door."
	duty = "Offer strip club services. Some of your clientele may be... Unusual, but you are either addicted to vampire bites, or bribed to listen little and say even less."
	minimal_masquerade = 3
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_KIASYD)


/datum/outfit/job/strip
	name = "Stripper"
	jobtype = /datum/job/vampire/citizen
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/strip
	id = /obj/item/cockclock
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit=1)

/datum/outfit/job/strip/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/vampire/white
		uniform = /obj/item/clothing/under/vampire/slickback
	else
		shoes = /obj/item/clothing/shoes/vampire/heels
		uniform = /obj/item/clothing/under/vampire/burlesque

/obj/effect/landmark/start/strip
	name = "Strip"
	icon_state = "Assistant"
