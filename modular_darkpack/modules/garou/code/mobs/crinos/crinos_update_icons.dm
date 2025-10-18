/mob/living/carbon/human/fera/crinos/update_icons()
	cut_overlays()

	var/laid_down = FALSE

	if(stat >= SOFT_CRIT || IsParalyzed() || body_position == LYING_DOWN)
		icon_state = HAS_TRAIT(src, TRAIT_WYRMTAINTED) ? "spiral[sprite_color]_rest" : "[sprite_color]_rest"
		laid_down = TRUE
	else
		icon_state = HAS_TRAIT(src, TRAIT_WYRMTAINTED) ? "spiral[sprite_color]" : "[sprite_color]"

	if(sprite_scar)
		var/mutable_appearance/scar_overlay = mutable_appearance(icon, "scar[sprite_scar][laid_down ? "_rest" : ""]")
		add_overlay(scar_overlay)

	if(sprite_apparel)
		var/mutable_appearance/clothing_overlay = mutable_appearance(icon, "[sprite_apparel][laid_down ? "_rest" : ""]")
		add_overlay(clothing_overlay)

	if(sprite_hair)
		var/mutable_appearance/hair_overlay = mutable_appearance(icon, "hair[sprite_hair][laid_down ? "_rest" : ""]")
		hair_overlay.color = sprite_hair_color
		add_overlay(hair_overlay)

	var/mutable_appearance/eye_overlay = mutable_appearance(icon, "eyes[laid_down ? "_rest" : ""]")
	eye_overlay.color = sprite_eye_color
	eye_overlay.plane = ABOVE_LIGHTING_PLANE
	add_overlay(eye_overlay)

	update_held_items()
	..()

/mob/living/carbon/human/fera/crinos/regenerate_icons()
	if(!..())
		update_transform()

/mob/living/carbon/human/fera/crinos/update_transform() //The old method of updating lying/standing was update_icons(). Aliens still expect that.
	. = ..()
	update_icons()

/mob/living/carbon/human/fera/crinos/update_damage_overlays()
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
