/datum/mind
	/// Guestbook datum, in case we actually make use of the guestbook mechanics
	var/datum/guestbook/guestbook

/datum/mind/New(_key)
	. = ..()
	guestbook = new()
	if(current?.real_name)
		LAZYADDASSOC(guestbook.known_names, current.real_name, current.real_name)

/datum/mind/Destroy()
	QDEL_NULL(guestbook)
	return ..()
