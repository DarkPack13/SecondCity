// A unpowered varient of a hydroponics tray.
/obj/machinery/hydroponics/simple
	abstract_type = /obj/machinery/hydroponics/simple
	icon = 'modular_darkpack/modules/drugs/icons/tray.dmi'
	circuit = null
	use_power = NO_POWER_USE
	unwrenchable = TRUE
	self_sustaining_overlay_icon_state = null

/obj/machinery/hydroponics/simple/update_status_light_overlays()
	if(waterlevel > 10)
		. += mutable_appearance('modular_darkpack/modules/drugs/icons/tray.dmi', "tray_wet")
	return // Has no lights

/obj/machinery/hydroponics/simple/click_ctrl(mob/user)
	return CLICK_ACTION_BLOCKING //Soil has no electricity.

/obj/machinery/hydroponics/simple/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/hydroponics/simple/base_item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(default_deconstruction_crowbar(tool, TRUE))
		return

	return ..()

/obj/machinery/hydroponics/simple/wooden
	name = "wooden planter box"
	desc = "A wooden plant tray"
	icon_state = "wooden_tray"
	tray_offset = 2

/obj/machinery/hydroponics/simple/wooden/on_deconstruction()
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 5)
	return TRUE

/obj/machinery/hydroponics/simple/metal
	name = "metal planter box"
	desc = "A metal plant tray"
	icon_state = "metal_tray"
	tray_offset = 3

/obj/machinery/hydroponics/simple/metal/on_deconstruction()
	new /obj/item/stack/sheet/iron(drop_location(), 5)
	return TRUE

/obj/machinery/hydroponics/simple/metal/unanchored
	anchored = FALSE
