/mob/living/carbon/human/toggle_resting()
	. = ..()

	update_shadow()

/mob/living/carbon/human/proc/update_shadow()
	if (body_position != LYING_DOWN)
		if (overlays_standing[UNDERSHADOW_LAYER])
			return
		var/mutable_appearance/lying_overlay = mutable_appearance('icons/wod13/icons.dmi', "shadow", -UNDERSHADOW_LAYER)
		lying_overlay.pixel_z = -4
		lying_overlay.alpha = 64
		overlays_standing[UNDERSHADOW_LAYER] = lying_overlay
		apply_overlay(UNDERSHADOW_LAYER)
	else if (overlays_standing[UNDERSHADOW_LAYER])
		remove_overlay(UNDERSHADOW_LAYER)
