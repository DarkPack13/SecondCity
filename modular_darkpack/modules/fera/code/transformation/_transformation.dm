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
	if(transformations)
		possible_shapes = transformations

/datum/action/cooldown/spell/shapeshift/transformation/do_shapeshift(mob/living/carbon/caster)
	if(caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM))
		caster.balloon_alert(caster, "can't transform!")
		return
	do_shapeshift_animation(caster)
	. = ..()

/datum/action/cooldown/spell/shapeshift/transformation/do_unshapeshift(mob/living/caster)
	if(caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM))
		caster.balloon_alert(caster, "can't transform!")
		return
	do_shapeshift_animation(caster)
	. = ..()
	shapeshift_type = null

/datum/action/cooldown/spell/shapeshift/transformation/proc/do_shapeshift_animation(mob/living/carbon/caster)
	ADD_TRAIT(caster, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	caster.Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)
	var/mob/living/carbon/human/fera/fera_shapeshift_type = shapeshift_type
	playsound(caster, fera_shapeshift_type?.transformation_sound, 50)
	var/matrix/source_transform = matrix(caster.transform) //aka transform.Copy()
	source_transform.Scale(0.75, 0.75)
	animate(caster, transform = source_transform, color = "#000000", time = TRANSFORMATION_DURATION)
	sleep(TRANSFORMATION_DURATION) //this pains me, please tell me if anyone finds a better solution for this
	finish_shapeshift_animation(caster)

/datum/action/cooldown/spell/shapeshift/transformation/proc/finish_shapeshift_animation(mob/living/carbon/caster)
	animate(caster, transform = null, color = "#FFFFFF", time = 10)
	caster.transformation_timer = null
	REMOVE_TRAIT(caster, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
