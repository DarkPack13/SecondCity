#define TRANSFORMATION_DURATION 22
/// Will be removed once the transformation is complete.
#define TEMPORARY_TRANSFORMATION_TRAIT "temporary_transformation"

/datum/action/cooldown/spell/shapeshift/transformation
	name = "Transform"
	desc = "Transform into your different form!"
	school = SCHOOL_UNSET
	spell_requirements = NONE
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_PHASED|AB_CHECK_INCAPACITATED|AB_CHECK_LYING
	revert_on_death = FALSE
	possible_shapes = list(/mob/living/carbon/human/fera/lupus) //Default is lupus form. CHANGE THIS FOR YOUR SUBTYPES.

/datum/action/cooldown/spell/shapeshift/transformation/New(Target, list/transformations)
	. = ..()
	if(transformations)
		possible_shapes = transformations
		possible_shapes += /mob/living/carbon/human

/datum/action/cooldown/spell/shapeshift/transformation/before_cast(mob/living/cast_on)
	. = ..()
	if(shapeshift_type == cast_on.type)
		shapeshift_type = null
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/shapeshift/transformation/do_shapeshift(mob/living/carbon/caster)

	if(caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM))
		caster.balloon_alert(caster, "can't transform!")
		return
	if(shapeshift_type.type == /mob/living/carbon/human)
		return
	do_shapeshift_animation(caster)
	if(caster.body_position == LYING_DOWN) // User might stand up during animation.
		caster.balloon_alert(caster, "must stand up!")
		shapeshift_type = null
		return
	var/unshapeshifted_mob = ..()
	do_post_shapeshift_adjustments(caster, unshapeshifted_mob)
	return unshapeshifted_mob

/datum/action/cooldown/spell/shapeshift/transformation/do_unshapeshift(mob/living/carbon/caster)
	if(caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM))
		caster.balloon_alert(caster, "can't transform!")
		return
	do_shapeshift_animation(caster)
	if(caster.body_position == LYING_DOWN) // User might stand up during animation.
		caster.balloon_alert(caster, "must stand up!")
		shapeshift_type = null
		return
	var/unshapeshifted_mob = ..()
	shapeshift_type = null
	do_post_shapeshift_adjustments(caster, unshapeshifted_mob)
	return unshapeshifted_mob

/datum/action/cooldown/spell/shapeshift/transformation/proc/do_shapeshift_animation(mob/living/carbon/caster)
	ADD_TRAIT(caster, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	caster.Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)
	var/mob/living/carbon/human/human_shapeshift_type = shapeshift_type
	playsound(caster, human_shapeshift_type.transformation_sound, 50)
	var/matrix/source_transform = matrix(caster.transform)
	var/matrix/new_transform = matrix(source_transform)
	new_transform.Scale(0.75, 0.75)
	animate(caster, transform = new_transform, color = "#000000", time = TRANSFORMATION_DURATION)
	sleep(TRANSFORMATION_DURATION) //this pains me, please tell me if anyone finds a better solution for this
	finish_shapeshift_animation(caster, source_transform)

/datum/action/cooldown/spell/shapeshift/transformation/proc/finish_shapeshift_animation(mob/living/carbon/caster, source_transform)
	animate(caster, transform = source_transform, color = "#FFFFFF", time = 10)
	caster.transformation_timer = null
	REMOVE_TRAIT(caster, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)

/datum/action/cooldown/spell/shapeshift/transformation/proc/do_post_shapeshift_adjustments(mob/living/carbon/caster, mob/living/carbon/unshapeshifted_mob)
	return

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
