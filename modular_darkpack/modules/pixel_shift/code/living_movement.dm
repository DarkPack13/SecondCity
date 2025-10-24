/**
 * Returns true if a mob can turn to face things
 *
 * Conditions:
 * * client.last_turn > world.time
 * * not dead or unconcious
 * * not anchored
 * * no transform not set
 * * we are not restrained
 */
/mob/proc/can_face()
	if(stat >= UNCONSCIOUS)
		return FALSE
	if(anchored)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return FALSE
	return TRUE

///Checks mobility move as well as parent checks
/mob/living/can_face()
	if(!(mobility_flags & MOBILITY_MOVE))
		return FALSE
	return ..()


/mob/living/proc/get_standard_pixel_x_offset(lying = 0)
	return initial(pixel_x)

/mob/living/proc/get_standard_pixel_y_offset(lying = 0)
	return initial(pixel_y)
