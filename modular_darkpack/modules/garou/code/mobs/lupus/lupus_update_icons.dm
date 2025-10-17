/mob/living/carbon/human/fera/lupus/update_icons()
	cut_overlays()

	var/laid_down = FALSE

	if(stat >= SOFT_CRIT || IsParalyzed() || body_position == LYING_DOWN)
		icon_state = HAS_TRAIT(src, TRAIT_WYRMTAINTED) ? "spiral[sprite_color]_rest" : "[sprite_color]_rest"
		laid_down = TRUE
	else
		icon_state = HAS_TRAIT(src, TRAIT_WYRMTAINTED) ? "spiral[sprite_color]" : "[sprite_color]"
	if(HAS_TRAIT(src, TRAIT_MOVE_FLYING))
		icon_state = HAS_TRAIT(src, TRAIT_WYRMTAINTED) ? "spiral[sprite_color]_flying" :"[sprite_color]_flying"

	switch(getFireLoss()+getBruteLoss())
		if(25 to 75)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage1[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)
		if(75 to 150)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage2[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)
		if(150 to INFINITY)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage3[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)

	var/mutable_appearance/eye_overlay = mutable_appearance(icon, "eyes[laid_down ? "_rest" : HAS_TRAIT(src, TRAIT_MOVE_FLYING) ? "_flying" : ""]")
	eye_overlay.color = sprite_eye_color
	eye_overlay.plane = ABOVE_LIGHTING_PLANE
	add_overlay(eye_overlay)
	. = ..()

/mob/living/carbon/human/fera/lupus/regenerate_icons()
	if(!..())
		update_transform()

/mob/living/carbon/human/fera/lupus/update_transform()
	. = ..()
	update_icons()

