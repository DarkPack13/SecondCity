/obj/effect/mapping_helpers/door/access
	layer = DOOR_ACCESS_HELPER_LAYER
	icon_state = "access_helper"
	var/lock_id

/obj/effect/mapping_helpers/door/access/payload(obj/structure/vampdoor/payload)
	payload.lock_id = lock_id

/obj/effect/mapping_helpers/door/access/all
	name = "all access"
	desc = "Any keys can lock or unlock this door."
	lock_id = LOCKACCESS_ALL

/obj/effect/mapping_helpers/door/access/camarilla
	lock_id = LOCKACCESS_CAMARILLA

/obj/effect/mapping_helpers/door/access/anarch
	lock_id = LOCKACCESS_ANARCH

/obj/effect/mapping_helpers/door/access/npc/payload(obj/structure/vampdoor/payload)
	payload.lock_id = "npc[rand(1, 20)]"
