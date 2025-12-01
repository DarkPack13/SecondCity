/atom/movable/screen/vtm_zone
	name = "zone"
	icon = 'modular_darkpack/modules/deprecated/icons/48x48.dmi'
	icon_state = "masquerade"
	layer = HUD_LAYER
	plane = HUD_PLANE
	alpha = 64

/mob/living/proc/update_zone_hud()
	if(!client || !hud_used)
		return
	if(hud_used.zone_icon)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			hud_used.zone_icon.icon_state = "[V.zone_type]"
			if(V.zone_type == ZONE_ELYSIUM)
				if(!HAS_TRAIT(src, TRAIT_ELYSIUM))
					ADD_TRAIT(src, TRAIT_ELYSIUM, "elysium")
			else
				if(HAS_TRAIT(src, TRAIT_ELYSIUM))
					REMOVE_TRAIT(src, TRAIT_ELYSIUM, "elysium")
