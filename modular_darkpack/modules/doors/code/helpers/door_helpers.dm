//door helpers
/obj/effect/mapping_helpers/door
	abstract_type = /obj/effect/mapping_helpers/door
	layer = DOOR_HELPER_LAYER
	late = TRUE

/obj/effect/mapping_helpers/door/Initialize(mapload)
	. = ..()
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return

	var/obj/structure/vampdoor/door = locate(/obj/structure/vampdoor) in loc
	if(!door)
		log_mapping("[src] failed to find a door at [AREACOORD(src)]")
		return

	payload(door)

/obj/effect/mapping_helpers/door/LateInitialize()
	var/obj/structure/vampdoor/door = locate(/obj/structure/vampdoor) in loc
	if(!door)
		qdel(src)
		return

	late_payload(door)

/obj/effect/mapping_helpers/door/proc/payload(obj/structure/vampdoor/payload)
	return

/obj/effect/mapping_helpers/door/proc/late_payload(obj/structure/vampdoor/payload)
	return

/obj/effect/mapping_helpers/door/lock
/obj/effect/mapping_helpers/door/lock/payload(obj/structure/vampdoor/payload)
	payload.locked = TRUE

/obj/effect/mapping_helpers/door/unlock
/obj/effect/mapping_helpers/door/unlock/payload(obj/structure/vampdoor/payload)
	payload.locked = FALSE

/obj/effect/mapping_helpers/door/toggle_lock
/obj/effect/mapping_helpers/door/toggle_lock/payload(obj/structure/vampdoor/payload)
	payload.locked = !payload.locked


/obj/effect/mapping_helpers/door/lock_difficulty
	var/lock_difficulty

/obj/effect/mapping_helpers/door/toggle_lock/payload(obj/structure/vampdoor/payload)
	payload.lockpick_difficulty = lock_difficulty

/obj/effect/mapping_helpers/door/lock_difficulty/one
	lock_difficulty = 1

/obj/effect/mapping_helpers/door/lock_difficulty/two
	lock_difficulty = 2

/obj/effect/mapping_helpers/door/lock_difficulty/three
	lock_difficulty = 3

/obj/effect/mapping_helpers/door/lock_difficulty/four
	lock_difficulty = 4

/obj/effect/mapping_helpers/door/lock_difficulty/five
	lock_difficulty = 5

/obj/effect/mapping_helpers/door/lock_difficulty/six
	lock_difficulty = 6

/obj/effect/mapping_helpers/door/lock_difficulty/seven
	lock_difficulty = 7

/obj/effect/mapping_helpers/door/lock_difficulty/eight
	lock_difficulty = 8

/obj/effect/mapping_helpers/door/lock_difficulty/nine
	lock_difficulty = 9

/obj/effect/mapping_helpers/door/lock_difficulty/ten
	lock_difficulty = 10
