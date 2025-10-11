// Base type for all transformations for fera, such as corax and garou.
/mob/living/carbon/fera
	rotate_on_lying = FALSE

/mob/living/carbon/fera/Initialize(mapload)
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)
	create_bodyparts() //initialize bodyparts
	. = ..()

/mob/living/carbon/fera/update_damage_overlays() //fera don't have damage overlays.
	return

/mob/living/carbon/fera/update_body(is_creating = FALSE) // we don't use the bodyparts or body layers for fera.
	return

/mob/living/carbon/fera/update_body_parts() //we don't use the bodyparts layer for fera.
	return
