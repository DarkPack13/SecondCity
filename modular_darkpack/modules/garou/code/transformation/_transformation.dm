#define TRANSFORMATION_DURATION 22
/// Will be removed once the transformation is complete.
#define TEMPORARY_TRANSFORMATION_TRAIT "temporary_transformation"

/mob/living/carbon/proc/do_transformation(/datum/fera_form/form)
	if (transformation_timer || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return

	if(!istype(src))
		return

	//Make mob invisible and spawn animation
	ADD_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)

	var/matrix/source_transform = matrix(transform) //aka transform.Copy()
	source_transform.Scale(0.75, 0.75)
	animate(src, transform = source_transform, color = "#000000", time = TRANSFORMATION_DURATION)

	transformation_timer = addtimer(CALLBACK(src, PROC_REF(finish_transformation)), TRANSFORMATION_DURATION, TIMER_UNIQUE)

/mob/living/carbon/proc/finish_transformation()
	animate(src, transform = null, color = "#FFFFFF", time = 10)
	transformation_timer = null
	REMOVE_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
