
/datum/job/vampire/dealer
	title = "Dealer"
	department_head = list("Yourself")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "None. You are beholden only to yourself."
	selection_color = "#edc009"
	exp_type_department = EXP_TYPE_WAREHOUSE // This is so the jobs menu can work properly

	outfit = /datum/outfit/job/dealer

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_DEALER
	bounty_types = CIV_JOB_RANDOM

//	minimal_generation = 12	//Uncomment when players get exp enough

	my_contact_is_important = TRUE
	known_contacts = list("Prince","Seneschal", "Sheriff", "Baron")
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_CAPPADOCIAN)

	v_duty = "You provide both legal and illegal supplies to those that get busy during the night. You are your own man yet you know people are out for you. Time to buckle in..."
	minimal_masquerade = 3
	allowed_species = list("Vampire", "Werewolf", "Kuei-Jin")

/datum/outfit/job/dealer
	name = "Dealer"
	jobtype = /datum/job/vampire/dealer

	id = /obj/item/card/id/dealer
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/brown
	glasses = /obj/item/clothing/glasses/vampire/sun
	l_pocket = /obj/item/vamp/phone/dealer
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit/rich=1)

/datum/outfit/job/dealer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels/red

/obj/effect/landmark/start/dealer
	name = "Dealer"
	icon_state = "Dealer"
