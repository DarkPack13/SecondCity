/// Helper for checking of someone's shapeshifted currently.
#define is_shifted(mob) mob.has_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera)
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
	var/image/human_form_image

/datum/action/cooldown/spell/shapeshift/transformation/New(Target, list/transformations)
	. = ..()
	if(transformations)
		possible_shapes = transformations
		possible_shapes += /mob/living/carbon/human


/datum/action/cooldown/spell/shapeshift/transformation/Destroy(mob/remove_from)
	human_form_image = null
	return ..()

/datum/action/cooldown/spell/shapeshift/transformation/before_cast(mob/living/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	if(shapeshift_type)
		// If another shapeshift spell was casted while we're already shifted, they could technically go to do_unshapeshift().
		// However, we don't really want people casting shapeshift A to un-shapeshift from shapeshift B,
		// as it could cause bugs or unintended behavior. So we'll just stop them here.
		if(is_shifted(cast_on) && !is_type_in_list(cast_on, possible_shapes))
			to_chat(cast_on, span_warning("This spell won't un-shapeshift you from this form!"))
			return . | SPELL_CANCEL_CAST

	if(length(possible_shapes) == 1)
		shapeshift_type = possible_shapes[1]
		return

	// Not bothering with caching these as they're only ever shown once
	var/list/shape_names_to_types = list()
	var/list/shape_names_to_image = list()
	if(!human_form_image)
		human_form_image = image(cast_on.appearance)

	if(!length(shape_names_to_types) || !length(shape_names_to_image))
		for(var/atom/path as anything in possible_shapes)
			if(path == /mob/living/carbon/human)
				var/mob/living/carbon/human/human_path = path
				var/shape_name = cast_on.real_name
				shape_names_to_types[shape_name] = human_path
				shape_names_to_image[shape_name] = get_small_overlay(human_form_image)
			else
				var/shape_name = initial(path.name)
				shape_names_to_types[shape_name] = path
				shape_names_to_image[shape_name] = get_small_overlay(image(icon = initial(path.icon), icon_state = initial(path.icon_state)))

	var/picked_type = show_radial_menu(
		cast_on,
		cast_on,
		shape_names_to_image,
		custom_check = CALLBACK(src, PROC_REF(check_menu), cast_on),
		radius = 38,
	)

	if(!picked_type)
		return . | SPELL_CANCEL_CAST

	var/atom/shift_type = shape_names_to_types[picked_type]
	if(!ispath(shift_type))
		return . | SPELL_CANCEL_CAST

	shapeshift_type = shift_type || pick(possible_shapes)
	if(QDELETED(src) || QDELETED(owner) || !can_cast_spell(feedback = FALSE))
		return . | SPELL_CANCEL_CAST

	if(shapeshift_type && (shapeshift_type == cast_on.type))
		shapeshift_type = null
		return . | SPELL_CANCEL_CAST


/datum/action/cooldown/spell/shapeshift/transformation/cast(mob/living/cast_on, force)
	. = ..()
	cast_on.buckled?.unbuckle_mob(cast_on, force = TRUE)

	var/currently_ventcrawling = (cast_on.movement_type & VENTCRAWLING)
	var/mob/living/resulting_mob

	var/unshapeshifted_creature
	var/chosen_shapeshift_type
	// Do the shift back or forth
	if(is_shifted(cast_on))
		chosen_shapeshift_type = shapeshift_type
		unshapeshifted_creature = do_unshapeshift(cast_on, FALSE, force)
		shapeshift_type = chosen_shapeshift_type
	if(!unshapeshifted_creature)
		unshapeshifted_creature = cast_on
	resulting_mob = do_shapeshift(unshapeshifted_creature, chosen_shapeshift_type ? TRUE : FALSE, force)

	// The shift is done, let's make sure they're in a valid state now
	// If we're not ventcrawling, we don't need to mind
	if(!currently_ventcrawling || !resulting_mob)
		return

	// We are ventcrawling - can our new form support ventcrawling?
	if(HAS_TRAIT(resulting_mob, TRAIT_VENTCRAWLER_ALWAYS) || HAS_TRAIT(resulting_mob, TRAIT_VENTCRAWLER_NUDE))
		return

	// Uh oh. You've shapeshifted into something that can't fit into a vent, while ventcrawling.
	eject_from_vents(resulting_mob)

/datum/action/cooldown/spell/shapeshift/transformation/do_shapeshift(mob/living/carbon/caster, skip_animation = FALSE, force)
	if((caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM)) && !force)
		caster.balloon_alert(caster, "can't transform!")
		return
	if(shapeshift_type.type == /mob/living/carbon/human)
		return
	if(!skip_animation)
		do_shapeshift_animation(caster)
	if(caster.body_position == LYING_DOWN && !force) // User might stand up during animation.
		caster.balloon_alert(caster, "must stand up!")
		shapeshift_type = null
		return

	var/mob/living/new_shape = create_shapeshift_mob(caster.loc)
	var/datum/status_effect/shapechange_mob/shapechange = new_shape.apply_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera, caster, src)
	if(!shapechange)
		// We failed to shift, maybe because we were already shapeshifted?
		// Whatver the case, this shouldn't happen, so throw a stack trace.
		to_chat(caster, span_warning("You can't shapeshift in this form!"))
		stack_trace("[type] do_shapeshift was called when the mob was already shapeshifted (from a spell).")
		return

	do_post_shapeshift_adjustments(caster, new_shape)
	return new_shape

/datum/action/cooldown/spell/shapeshift/transformation/do_unshapeshift(mob/living/carbon/caster, skip_animation = FALSE, force)
	if((caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM)) && !force)
		caster.balloon_alert(caster, "can't transform!")
		return
	if(!skip_animation)
		do_shapeshift_animation(caster)
	if(caster.body_position == LYING_DOWN && !force) // User might stand up during animation.
		caster.balloon_alert(caster, "must stand up!")
		shapeshift_type = null
		return

	var/datum/status_effect/shapechange_mob/shapechange = caster.has_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera)
	if(!shapechange)
		// We made it to do_unshapeshift without having a shapeshift status effect, this shouldn't happen.
		to_chat(caster, span_warning("You can't un-shapeshift from this form!"))
		stack_trace("[type] do_unshapeshift was called when the mob wasn't even shapeshifted (from a spell).")
		return

	var/mob/living/unshapeshifted_mob = shapechange.caster_mob
	caster.remove_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera)
	shapeshift_type = null
	return unshapeshifted_mob

/datum/action/cooldown/spell/shapeshift/transformation/proc/do_shapeshift_animation(mob/living/carbon/human/caster)
	ADD_TRAIT(caster, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)
	caster.Stun(TRANSFORMATION_DURATION, ignore_canstun = TRUE)
	var/mob/living/carbon/human/human_shapeshift_type = shapeshift_type
	var/matrix/source_transform = matrix(caster.transform)
	var/matrix/new_transform = matrix(source_transform)
	if(human_shapeshift_type)
		playsound(caster, human_shapeshift_type.transformation_sound, 50)
		new_transform.Scale(human_shapeshift_type.transformation_size_width, human_shapeshift_type.transformation_size_height)
	animate(caster, transform = new_transform, color = "#000000", time = TRANSFORMATION_DURATION)
	sleep(TRANSFORMATION_DURATION) //this pains me, please tell me if anyone finds a better solution for this
	finish_shapeshift_animation(caster, source_transform)

/datum/action/cooldown/spell/shapeshift/transformation/proc/finish_shapeshift_animation(mob/living/carbon/caster, source_transform)
	animate(caster, transform = source_transform, color = "#FFFFFF", time = 10)
	caster.transformation_timer = null
	REMOVE_TRAIT(caster, TRAIT_NO_TRANSFORM, TEMPORARY_TRANSFORMATION_TRAIT)

/datum/action/cooldown/spell/shapeshift/transformation/proc/do_post_shapeshift_adjustments(mob/living/carbon/caster, mob/living/carbon/unshapeshifted_mob)
	caster.dna.copy_dna(unshapeshifted_mob.dna)

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
#undef is_shifted
