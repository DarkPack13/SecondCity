#define ui_zone_hud "TOP-0:-8,CENTER-0:-8"
/atom/movable/screen/zone_hud
	name = "zone"
	icon = 'modular_darkpack/modules/areas/icons/zone_hud.dmi'
	icon_state = "masquerade"
	alpha = 32
	screen_loc = ui_zone_hud

/mob/living/proc/update_zone_hud(mob/source, area/new_area)
	SIGNAL_HANDLER

	if(hud_used?.zone_icon)
		if(!istype(new_area, /area/vtm))
			return
		var/area/vtm/our_area = new_area
		hud_used.zone_icon.icon_state = "[our_area.zone_type]"
#undef ui_zone_hud
