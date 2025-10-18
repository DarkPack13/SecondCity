/mob/living/carbon/human/fera/hispo/update_icons()
	cut_overlays()

	var/laid_down = FALSE

	if(stat >= SOFT_CRIT || IsParalyzed() || body_position == LYING_DOWN)
		icon_state = "[sprite_color]_rest"
		laid_down = TRUE
	else
		icon_state = "[sprite_color]"

	var/mutable_appearance/eye_overlay = mutable_appearance(icon, "eyes[laid_down ? "_rest" : HAS_TRAIT(src, TRAIT_MOVE_FLYING) ? "_flying" : ""]")
	eye_overlay.color = sprite_eye_color
	eye_overlay.plane = ABOVE_LIGHTING_PLANE
	add_overlay(eye_overlay)
	. = ..()

/mob/living/carbon/human/fera/hispo/regenerate_icons()
	if(!..())
		update_transform()

/mob/living/carbon/human/fera/hispo/update_transform()
	. = ..()
	update_icons()

/mob/living/carbon/human/fera/hispo/update_damage_overlays()
	remove_overlay(DAMAGE_LAYER)
	var/laid_down = FALSE
	if(stat >= SOFT_CRIT || IsParalyzed() || body_position == LYING_DOWN)
		laid_down = TRUE
	var/mutable_appearance/damage_overlay
	if(isnull(damage_overlay) && (getBruteLoss()))
		damage_overlay = mutable_appearance('icons/mob/effects/dam_mob.dmi', "blank", -DAMAGE_LAYER, appearance_flags = KEEP_TOGETHER)
	switch(getBruteLoss())
		if(25 to 75)
			damage_overlay = mutable_appearance(icon, "damage1[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)
		if(75 to 150)
			damage_overlay = mutable_appearance(icon, "damage2[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)
		if(150 to INFINITY)
			damage_overlay = mutable_appearance(icon, "damage3[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)


	if(isnull(damage_overlay))
		return

	overlays_standing[DAMAGE_LAYER] = damage_overlay
	apply_overlay(DAMAGE_LAYER)
