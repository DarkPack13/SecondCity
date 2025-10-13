#define TRANSFORMATION_DURATION 22
/// Will be removed once the transformation is complete.
#define TEMPORARY_TRANSFORMATION_TRAIT "temporary_transformation"

/datum/action/innate/transformation
	name = "Transform"
	button_icon_state = "chameleon_outfit"
	desc = "Transform into your different form!"

	/// Our chosen type.
	var/mob/living/shapeshift_type
	/// All possible types we can become.
	/// This should be implemented even if there is only one choice.
	var/list/transformations_available

/datum/action/innate/transformation/New(Target, list/transformations)
	. = ..()
	transformations_available = transformations

/datum/action/innate/transformation/Activate()
	var/mob/living/carbon/carbon_owner = owner
	if(carbon_owner.stat)
		carbon_owner.balloon_alert(carbon_owner, "unconscious!")
		return

	if(length(transformations_available) == 1)
		shapeshift_type = transformations_available[1]

	// Not bothering with caching these as they're only ever shown once
	var/list/shape_names_to_types = list()
	var/list/shape_names_to_image = list()
	if(!length(shape_names_to_types) || !length(shape_names_to_image))
		for(var/atom/path as anything in transformations_available)
			var/shape_name = initial(path.name)
			shape_names_to_types[shape_name] = path
			shape_names_to_image[shape_name] = image(icon = initial(path.icon), icon_state = initial(path.icon_state))

	var/picked_type = show_radial_menu(owner, owner, shape_names_to_image, custom_check = CALLBACK(src, PROC_REF(check_menu), owner), radius = 38)
	shapeshift_type = shape_names_to_types[picked_type]
	if(!shapeshift_type || (shapeshift_type == carbon_owner.type))
		return

	carbon_owner.do_transformation(shapeshift_type)

/// Callback for the radial that allows the user to choose their species.
/datum/action/innate/transformation/proc/check_menu(mob/living/caster)
	if(QDELETED(src))
		return FALSE
	if(QDELETED(caster))
		return FALSE

	return !caster.incapacitated

/atom/movable/screen/alert/status_effect/shapeshifted/fera
	name = "Transformed"
	desc = "You're transformed into your non-breed form!"
	clickable_glow = FALSE

/datum/status_effect/shapechange_mob/fera
	alert_type = /atom/movable/screen/alert/status_effect/shapeshifted/fera
	status_type = STATUS_EFFECT_REPLACE

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
		remove_status_effect(/datum/status_effect/shapechange_mob/fera)
		return
	var/mob/living/new_shape = new shapeshift_type(loc)
	new_shape.apply_status_effect(/datum/status_effect/shapechange_mob/fera, src, src)

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
