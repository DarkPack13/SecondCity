/obj/item/sim_card
	name = "\improper SIM card"
	desc = "A SIM card with a phone number attached to it."
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/phones/icons/phone_onfloor.dmi')
	icon_state = "phonebook"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/phone_number = ""
	var/datum/weakref/phone_weakref = null

/obj/item/sim_card/Initialize(mapload)
	. = ..()
	if(!phone_number)
		phone_number = SSphones.generate_phone_number(src)

/obj/item/sim_card/Destroy(force)
	. = ..()
	SSphones.assigned_phone_numbers.Remove(src)
	if(SSphones.published_phone_numbers[phone_number])
		SSphones.published_phone_numbers.Remove(src)
	phone_weakref = null

/obj/item/sim_card/examine(mob/user)
	. = ..()
	. += span_notice("[EXAMINE_HINT("Interact")] to crush it in your hands.")

/obj/item/sim_card/attack_self(mob/user, modifiers)
	. = ..()

	balloon_alert(user, "you start crushing [src]!")
	if(do_after(user, 5 SECONDS, src))
		balloon_alert(user, "you crush [src]!")
		new /obj/effect/decal/cleanable/blood/gibs/robot_debris(get_turf(user))
		qdel(src)
		return TRUE
	return FALSE

////////////////////////////////////////////////////////////////////////////////////////

/obj/item/sim_card/emergency
	name = "\improper Emergency Services SIM card"
	desc = "A SIM card with the number of 911."
	phone_number = "911"

/obj/item/sim_card/emergency/Initialize(mapload)
	SSphones.assigned_phone_numbers[src] = phone_number
	. = ..()

/obj/item/sim_card/cleaner
	name = "\improper Cleaning Services SIM card"
	desc = "A SIM card with the number of the cleaners."
	phone_number = "1415444444"

/obj/item/sim_card/cleaner/Initialize(mapload)
	SSphones.assigned_phone_numbers[src] = phone_number
	. = ..()

/obj/item/sim_card/landline
	name = "\improper Landline SIM card"
	desc = "Please put me back into the payphone."

/obj/item/sim_card/landline/Initialize(mapload)
	phone_number = SSphones.generate_phone_number(src, TRUE)
	. = ..()
