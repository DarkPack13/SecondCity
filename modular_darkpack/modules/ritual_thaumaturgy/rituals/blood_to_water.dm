/obj/ritualrune/blood_to_water
	name = "Blood To Water"
	desc = "Purges all blood in range into the water."
	icon_state = "rune8"
	word = "CL-ENE"

/obj/ritualrune/blood_to_water/complete()
	for(var/atom/A in range(7, src))
		A.wash(CLEAN_WASH)
	qdel(src)
