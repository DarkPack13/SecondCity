/mob/living/carbon/Destroy()
	QDEL_NULL(suckbar)
	suckbar_loc = null
	GLOB.masquerade_breakers_list -= src
	return ..()
