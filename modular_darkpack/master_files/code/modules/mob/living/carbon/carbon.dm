/mob/living/carbon/Destroy()
	QDEL_NULL(suckbar)
	suckbar_loc = null
	if(clan)
		clan.on_lose(src)
	clan = null
	GLOB.masquerade_breakers_list -= src
	return ..()
