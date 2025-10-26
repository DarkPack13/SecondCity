/datum/job/vamp/axe_leader
	title = "Screentender"
	faction = "Vampire"
	total_positions = 2
	spawn_positions = 2
	supervisors = "nobody. You are beholden only to yourself."
	selection_color = "#bb9d3d"

	outfit = /datum/outfit/job/axe_leader

	display_order = JOB_DISPLAY_ORDER_AXE_LEADER
	exp_required_type_department = EXP_TYPE_GANG

	known_contacts = list("Prince","Seneschal", "Sheriff", "Baron")
	allowed_species = list("Kuei-Jin", "Human")
	species_slots = list("Human" = 1, "Kuei-Jin" = 1)

	v_duty = "You lead a Scarlet Screen known as the Axe Gang. Wheather they are in the Know or not, Kindred, Werewolf, or a Hungry Dead like yourself, you offer shelter and fulfillment to these outcasts. Live up to your promises, and cultivate the Axe Gang."
	duty = "You lead a particular group, known as the Axe Gang, with the assistance of an enigmatic partner. You may understand the true identity of your co-conspirators, or not. Either way, they respect the position your co-leader and you hold."
	experience_addition = 20
	minimal_masquerade = 0

/datum/outfit/job/axe_leader/pre_equip(mob/living/carbon/human/H)
	..()
	H.grant_language(/datum/language/cantonese)

/datum/outfit/job/axe_leader
	name = "Screentender"
	jobtype = /datum/job/vamp/axe_leader
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/dealer
	l_pocket = /obj/item/vamp/phone/axe_leader
	r_pocket = /obj/item/vamp/keys/axes
	backpack_contents = list(/obj/item/vamp/keys/supply, /obj/item/flashlight=1, /obj/item/watch=1, /obj/item/passport=1, /obj/item/vamp/creditcard/rich=1, /obj/item/hatchet)

/obj/effect/landmark/start/axe_leader
	name = "Screentender"
	icon_state = "dealer"
