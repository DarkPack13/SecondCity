/datum/storage/bag/money/darkpack
	max_specific_storage = WEIGHT_CLASS_BULKY
	max_total_storage = 1000
	max_slots = 1000

//Overwrites old bag to accept new cash methods
/datum/storage/bag/money/darkpack/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/coin,
		/obj/item/stack/dollar,
		/obj/item/poker_chip,
		/obj/item/stack/sheet/mineral/diamond,
		/obj/item/stack/sheet/mineral/gold,
		/obj/item/stack/sheet/mineral/silver,
	))
