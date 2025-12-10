/datum/mind
	/// Guestbook datum, in case we actually make use of the guestbook mechanics
	var/datum/guestbook/guestbook

/datum/mind/New(_key)
	. = ..()
	guestbook = new()

/datum/mind/Destroy()
	QDEL_NULL(guestbook)
	return ..()
