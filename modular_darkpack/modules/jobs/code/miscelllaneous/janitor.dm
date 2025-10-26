
/datum/job/vampire/vjanitor
	title = JOB_STREET_JANITOR
	department_head = list("Prince")
	faction = FACTION_CITY
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Camarilla."


	outfit = /datum/outfit/job/vjanitor






	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)

	display_order = JOB_DISPLAY_ORDER_STREETJAN
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF)

	description = "Clean up all traces of Masquerade violations as the Camarilla has instructed you to."
	description = "Keep the streets clean. You are paid to keep your mouth shut about the things you see."
	minimal_masquerade = 0

/datum/outfit/job/vjanitor
	name = "Street Janitor"
	jobtype = /datum/job/vampire/vjanitor

	id = /obj/item/card/cleaning
	uniform = /obj/item/clothing/under/vampire/janitor
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/cleaning
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	gloves = /obj/item/clothing/gloves/vampire/cleaning
	backpack_contents = list(/obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/vamp/keys/hack=1, /obj/item/card/credit=1)

/obj/effect/landmark/start/vjanitor
	name = "Street Janitor"
	icon_state = "Street Janitor"
