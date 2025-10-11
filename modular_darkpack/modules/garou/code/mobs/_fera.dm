// Base type for all transformations for fera, such as corax and garou.
/mob/living/carbon/fera
	rotate_on_lying = FALSE

/mob/living/carbon/fera/Initialize(mapload)
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)
	create_bodyparts() //initialize bodyparts
	create_internal_organs()
	. = ..()
