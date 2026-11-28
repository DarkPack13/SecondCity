/obj/machinery/camera/on_observed_violation(atom/source, atom/movable/player_breacher)
	if(!can_use())
		return
	. = ..()
	if(.)
		SSmasquerade.log_phone_message("[c_tag || name] recorded footage of [player_breacher] doing something inexplicable.", src)
