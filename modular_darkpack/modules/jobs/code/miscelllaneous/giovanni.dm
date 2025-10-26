/datum/job/vampire/giovannielder
	title = JOB_CAPO
	department_head = list("Uncle Augie")
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Family and the Traditions"


	outfit = /datum/outfit/job/giovannielder





	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI

	minimal_generation = 11	//Uncomment when players get exp enough

	description = "Pure blood runs through your veins and, with it, old power. Throughout your long life you have learnt to hold onto two things and never let go: money, and family."
	minimal_masquerade = 0
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_CAPPADOCIAN)

/datum/outfit/job/giovannielder
	name = "Capo"
	jobtype = /datum/job/vampire/giovannielder

	id = /obj/item/watch
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/capo
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit/giovanniboss=1)

/datum/outfit/job/giovannielder/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/giovannielder
	name = "Capo"

/datum/job/vampire/giovanni
	title = JOB_LA_SQUADRA
	department_head = list("Capo")
	faction = FACTION_CITY
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Family and the Traditions"


	outfit = /datum/outfit/job/giovanni





	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI

	description = "Whether born or Embraced into the family, you are one of the Giovanni. Be you a necromancer, financier or lowly fledgling, remember that so long as you stand with your family, they too will stand with you."
	minimal_masquerade = 0
	allowed_species = list(SPECIES_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_CAPPADOCIAN)

/datum/outfit/job/giovanni
	name = "La Squadra"
	jobtype = /datum/job/vampire/giovanni

	id = /obj/item/watch
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit/rich=1)

/datum/outfit/job/giovanni/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/giovanni
	name = "La Squadra"

/datum/job/vampire/giovannimafia
	title = JOB_LA_FAMIGLIA
	department_head = list("Capo")
	faction = FACTION_CITY
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Family"


	outfit = /datum/outfit/job/giovannimafia





	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_required_type_department = EXP_TYPE_GIOVANNI

//	minimal_generation = 11	//Uncomment when players get exp enough

	allowed_species = list(SPECIES_GHOUL, SPECIES_HUMAN)
	description = "Your family is a strange one. Maybe you are strange too, because sitting next to your great uncles as an equal is something you are greatly interested in."
	minimal_masquerade = 0


/datum/outfit/job/giovannimafia
	name = "La Famiglia"
	jobtype = /datum/job/vampire/giovannimafia
	id = /obj/item/watch
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit=1)

/datum/outfit/job/giovannimafia/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/giovannimafia
	name = "La Famiglia"
