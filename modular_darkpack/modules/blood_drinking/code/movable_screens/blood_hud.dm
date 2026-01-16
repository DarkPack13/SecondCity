#define ui_living_bloodpool "EAST-1:28,CENTER-4:14"
/atom/movable/screen/bloodpool
	name = "bloodpool"
	//icon = 'modular_darkpack/modules/blood_drinking/icons/bloodpool.dmi'
	//32x32 version
	icon = 'modular_darkpack/modules/blood_drinking/icons/old_bloodpool.dmi'
	icon_state = "blood0"
	screen_loc = ui_living_bloodpool
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/bloodpool/Click()
	if(isliving(usr))
		var/mob/living/bloodbag = usr
		bloodbag.update_blood_hud()
		if(bloodbag.bloodpool > 0)
			to_chat(bloodbag, span_notice("You've got [bloodbag.bloodpool]/[bloodbag.maxbloodpool] blood points."))
		else
			to_chat(bloodbag, span_warning("You've got [bloodbag.bloodpool]/[bloodbag.maxbloodpool] blood points."))
	. = ..()

/mob/living/proc/update_blood_hud()
	if(!client || !hud_used)
		return
	if(hud_used.bloodpool_icon)
		var/emm = clamp(round((bloodpool/maxbloodpool)*10), 0, 10)
		hud_used.bloodpool_icon.icon_state = "blood[emm]"

#undef ui_living_bloodpool
