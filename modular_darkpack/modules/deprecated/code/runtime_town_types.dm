// DARKPACK TODO - This file should not exist and is only so we can save runtime town
/obj/machinery/atm
	name = "ATM Machine"
	desc = "For some reason its just stuck on the lock screen and all the buttons dont seem to do anything... (We have yet to reimplement atms! Sorry!)"
	icon = 'modular_darkpack/modules/economy/icons/atm.dmi'
	icon_state = "atm"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

	//light_system = STATIC_LIGHT
	light_color = COLOR_GREEN
	light_range = 2
	light_power = 1
	light_on = TRUE

/obj/machinery/computer/order_console/mining/restricted/police
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "merge_conflict_marker"
/obj/machinery/computer/order_console/mining/restricted/hospital
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "merge_conflict_marker"

/obj/vampire_computer
	name = "old computer"
	desc = "For some reason its just stuck on the lock screen and all the buttons dont seem to do anything... (We have yet to reimplement vampire computers! Sorry!)"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "computer"

/obj/vampire_computer/prince
	icon_state = "computerprince"

/obj/vampire_computer/box
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "oldcomp"
