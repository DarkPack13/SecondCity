/obj/effect/mapping_helpers/serial_number_log
	name = "Gun serial ref sheet landmark"
	desc = "Checks all the guns in the placed area then prints their name and numbers on a generated piece of paper!"

// Needs to load AFTER everything else so it properly checks guns in the defined area.
/obj/effect/mapping_helpers/serial_number_log/Initialize()
	..()
	. = INITIALIZE_HINT_LATELOAD

/obj/effect/mapping_helpers/serial_number_log/LateInitialize()
	. = ..()
	var/area/our_area = get_area(src)
	var/text = "Armoury Firearm Serial Numbers - Master List \n"
	for(var/obj/item/gun/ballistic/firearm in our_area.contents)
		if(firearm.serial_type)
			text += "[firearm.serial_type] - [firearm.name] \n"
	new /obj/item/paper(get_turf(src), text, "Armoury log")

// Changed version of 'delete_after_roundstart' from landmarks. This is done to stop errors or constantly adding guns that are left in the area to a sheet.
/obj/effect/mapping_helpers/serial_number_log/proc/after_round_start()
#if !defined(UNIT_TESTS) && !defined(MAP_TEST)
	qdel(src)
#endif
