/obj/effect/mapping_helpers/door/access
	layer = DOOR_ACCESS_HELPER_LAYER
	icon_state = "access_helper"
	var/lock_id

/obj/effect/mapping_helpers/door/access/payload(obj/structure/vampdoor/payload)
	payload.lock_id = lock_id

/obj/effect/mapping_helpers/door/access/all
	name = "all access"
	desc = "Any keys can lock or unlock this door."
	lock_id = LOCK_ACCESS_ANY
