/obj/item/smartphone/payphone
	name = "payphone"
	desc = "Ring ring. Ring ring. Ring ring."
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	icon_state = "payphone"
	ONFLOOR_ICON_HELPER(null)
	anchored = TRUE

/obj/item/smartphone/payphone/Initialize(mapload)
	sim_card = new /obj/item/sim_card/landline()
	sim_card.phone_weakref = WEAKREF(src)
	. = ..()

/obj/item/smartphone/clean
	desc = "The usual phone of a cleaning company used to communicate with employees"
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	icon_state = "phone_black"
	ONFLOOR_ICON_HELPER(null)
	anchored = TRUE

/obj/item/smartphone/clean/Initialize(mapload)
	sim_card = new /obj/item/sim_card/cleaner()
	sim_card.phone_weakref = WEAKREF(src)
	. = ..()

/obj/item/smartphone/emergency
	desc = "The 911 dispatch phone"
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	icon_state = "phone_red"
	ONFLOOR_ICON_HELPER(null)
	anchored = TRUE

/obj/item/smartphone/emergency/Initialize(mapload)
	sim_card = new /obj/item/sim_card/emergency()
	sim_card.phone_weakref = WEAKREF(src)
	. = ..()

