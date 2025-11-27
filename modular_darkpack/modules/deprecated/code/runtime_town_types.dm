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

/obj/effect/landmark/start/garou/glade/council
	name = "Amberglade Councillor"
	icon_state = "Prince"

/obj/effect/landmark/start/garou/glade/keeper
	name = "Amberglade Keeper"
	icon_state = "Clerk"

/obj/effect/landmark/start/garou/glade/catcher
	name = "Amberglade Truthcatcher"
	icon_state = "Clerk"

/obj/effect/landmark/start/garou/glade/warder
	name = "Amberglade Warder"
	icon_state = "Sheriff"

/obj/effect/landmark/start/garou/glade/guardian
	name = "Amberglade Guardian"
	icon_state = "Hound"

/obj/effect/landmark/start/garou/painted/council
	name = "Painted City Councillor"
	icon_state = "Prince"

/obj/effect/landmark/start/garou/painted/keeper
	name = "Painted City Keeper"
	icon_state = "Clerk"

/obj/effect/landmark/start/garou/painted/catcher
	name = "Painted City Truthcatcher"
	icon_state = "Clerk"

/obj/effect/landmark/start/garou/painted/warder
	name = "Painted City Warder"
	icon_state = "Sheriff"

/obj/effect/landmark/start/garou/painted/guardian
	name = "Painted City Guardian"
	icon_state = "Hound"

/obj/effect/landmark/start/garou/spiral/lead
	name = "Endron Branch Lead"
	icon_state = "Prince"

/obj/effect/landmark/start/garou/spiral/executive
	name = "Endron Executive"
	icon_state = "Clerk"

/obj/effect/landmark/start/garou/spiral/affairs
	name = "Endron Internal Affairs Agent"
	icon_state = "Clerk"

/obj/effect/landmark/start/garou/spiral/secchief
	name = "Endron Chief of Security"
	icon_state = "Sheriff"

/obj/effect/landmark/start/garou/spiral/sec
	name = "Endron Security Agent"
	icon_state = "Hound"

/obj/effect/landmark/start/garou/spiral/employee
	name = "Endron Employee"
	icon_state = "Hound"

/obj/effect/landmark/start/first_team
	name = "First Team"
	delete_after_roundstart = FALSE
