/mob/living/register_init_signals()
	. = ..()
	RegisterSignal(src, COMSIG_ENTER_AREA, PROC_REF(update_zone_hud))
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_OBFUSCATED), PROC_REF(make_invisible)) // POWERS - (Obfuscate Discipline)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_OBFUSCATED), PROC_REF(make_visible)) // POWERS - (Obfuscate Discipline)

/mob/living/proc/update_zone_hud(mob/source, area/new_area)
	SIGNAL_HANDLER

	if(hud_used?.zone_icon)
		if(!istype(new_area, /area/vtm))
			return
		var/area/vtm/our_area = new_area
		hud_used.zone_icon.icon_state = "[our_area.zone_type]"
