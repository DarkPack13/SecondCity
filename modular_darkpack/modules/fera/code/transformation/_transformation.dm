#define TRANSFORMATION_DURATION 22
/// Will be removed once the transformation is complete.
#define TEMPORARY_TRANSFORMATION_TRAIT "temporary_transformation"

/datum/action/cooldown/spell/shapeshift/transformation
	name = "Transform"
	desc = "Transform into your different form!"
	school = SCHOOL_UNSET
	spell_requirements = NONE
	revert_on_death = FALSE
	possible_shapes = list(/mob/living/carbon/human/fera/lupus) //Default is lupus form. CHANGE THIS FOR YOUR SUBTYPES.

/datum/action/cooldown/spell/shapeshift/transformation/New(Target, list/transformations)
	. = ..()
	possible_shapes = transformations


/*
/mob/living/carbon/proc/do_transformation(shapeshift_type)
	if (transformation_timer || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		balloon_alert(src, "can't transform!")
		return

	if(!istype(src))
		return

	//Make mob invisible and spawn animation
	ADD_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)

	var/matrix/source_transform = matrix(transform) //aka transform.Copy()
	source_transform.Scale(0.75, 0.75)
	animate(src, transform = source_transform, color = "#000000", time = TRANSFORMATION_DURATION)

	transformation_timer = addtimer(CALLBACK(src, PROC_REF(finish_transformation), shapeshift_type), TRANSFORMATION_DURATION, TIMER_UNIQUE)

/mob/living/carbon/proc/finish_transformation(shapeshift_type)
	animate(src, transform = null, color = "#FFFFFF", time = 10)
	transformation_timer = null
	REMOVE_TRAIT(src, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	if(ispath(shapeshift_type, /mob/living/carbon/human) && !(shapeshift_type in subtypesof(/mob/living/carbon/human)))
		remove_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera)
		return
	var/mob/living/new_shape = new shapeshift_type(loc)
	new_shape.apply_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera, src, src)
*/

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
