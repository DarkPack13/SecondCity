/atom/Click()
	. = ..()

	if(isliving(usr) && usr != src)
		var/mob/living/L = usr
		if(L.prepared_to_jump)
			L.jump(src)
