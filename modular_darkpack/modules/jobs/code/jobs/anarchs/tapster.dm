/datum/job/vamp/tapster
	title = JOB_TAPSTER
	description = "You are a bartender of the local biker hangout. Serve the eclectic clients that pass through, and try not to ask too many questions."
	department_head = list("Baron")
	faction = FACTION_ANARCHS
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_BARON_PUBLIC

	outfit = /datum/outfit/job/tapster

	display_order = JOB_DISPLAY_ORDER_TAPSTER
	known_contacts = list("Baron","Bouncer","Emissary","Sweeper")
	allowed_species = list("Human", "Ghoul")
	species_slots = list("Human" = 2, "Ghoul" = 2)
	minimal_masquerade = 0

/datum/outfit/job/tapster
	name = "Tapster"
	jobtype = /datum/job/vamp/tapster

	ears = /obj/item/p25radio
	id = /obj/item/card/tapster
	uniform = /obj/item/clothing/under/vampire/bouncer
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/anarch_limited
//	l_pocket = /obj/item/vamp/phone/tapster
	r_hand = /obj/item/melee/vampirearms/baseball
//	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/keys/hack=1, /obj/item/vamp/creditcard=1)


/obj/effect/landmark/start/tapster
	name = "Bartender"
	icon_state = "Bouncer"
