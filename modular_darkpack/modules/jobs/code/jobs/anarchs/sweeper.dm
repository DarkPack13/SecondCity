
/datum/job/vampire/sweeper
	title = "Sweeper"
	department_head = list("Baron")
	faction = "Vampire"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Baron"
	selection_color = "#434343"

	outfit = /datum/outfit/job/sweeper

	access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SWEEPER
	my_contact_is_important = TRUE
	known_contacts = list("Baron","Bouncer","Emissary","Sweeper")
	allowed_clans = list(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_SALUBRI)

	v_duty = "You are the observer of the anarchs. You watch out for any new kindred, suspicious individuals, and any new rumors near the anarch turf, and then report it to your anarchs."
	minimal_masquerade = 2

/datum/outfit/job/sweeper
	name = "Sweeper"
	jobtype = /datum/job/vampire/sweeper

	id = /obj/item/card/id/sweeper
	uniform = /obj/item/clothing/under/vampire/bouncer
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/anarch
	l_pocket = /obj/item/vamp/phone/anarch
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/keys/hack=1, /obj/item/card/credit=1, /obj/item/binoculars = 1)

/obj/effect/landmark/start/sweeper
	name = "Sweeper"
	icon_state = "Bouncer"
