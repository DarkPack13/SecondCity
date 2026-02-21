/mob/living/carbon/Initialize(mapload)
	. = ..()
	if(!examine_panel_tgui)
		examine_panel_tgui = new()
		examine_panel_tgui.holder = src

/mob/living/carbon/Destroy()
	examine_panel_tgui.holder = null
	QDEL_NULL(examine_panel_tgui)
	client?.images -= suckbar
	QDEL_NULL(suckbar)
	suckbar_loc = null
	GLOB.masquerade_breakers_list -= src
	return ..()
