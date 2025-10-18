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

/datum/action/cooldown/spell/shapeshift/transformation/cast(mob/living/cast_on)
	. = ..()
	cast_on.buckled?.unbuckle_mob(cast_on, force = TRUE)

	var/currently_ventcrawling = (cast_on.movement_type & VENTCRAWLING)
	var/mob/living/resulting_mob

	// DARKPACK EDIT START - Garou
	var/unshapeshifted_creature
	var/chosen_shapeshift_type
	// Do the shift back or forth
	if(is_shifted(cast_on))
		chosen_shapeshift_type = shapeshift_type
		unshapeshifted_creature = do_unshapeshift(cast_on)
		shapeshift_type = chosen_shapeshift_type
	if(!unshapeshifted_creature)
		unshapeshifted_creature = cast_on
	resulting_mob = do_shapeshift(unshapeshifted_creature, chosen_shapeshift_type ? TRUE : FALSE)
	// DARKPACK EDIT END

	// The shift is done, let's make sure they're in a valid state now
	// If we're not ventcrawling, we don't need to mind
	if(!currently_ventcrawling || !resulting_mob)
		return

	// We are ventcrawling - can our new form support ventcrawling?
	if(HAS_TRAIT(resulting_mob, TRAIT_VENTCRAWLER_ALWAYS) || HAS_TRAIT(resulting_mob, TRAIT_VENTCRAWLER_NUDE))
		return

	// Uh oh. You've shapeshifted into something that can't fit into a vent, while ventcrawling.
	eject_from_vents(resulting_mob)

/datum/action/cooldown/spell/shapeshift/transformation/do_shapeshift(mob/living/carbon/caster, skip_animation = FALSE)
	if(caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM))
		caster.balloon_alert(caster, "can't transform!")
		return
	if(shapeshift_type.type == /mob/living/carbon/human)
		return
	if(!skip_animation)
		do_shapeshift_animation(caster)
	if(caster.body_position == LYING_DOWN) // User might stand up during animation.
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

	// Make sure it's castable even in their new form.
	pre_shift_requirements = spell_requirements
	spell_requirements &= ~(SPELL_REQUIRES_HUMAN|SPELL_REQUIRES_WIZARD_GARB)
	ADD_TRAIT(new_shape, TRAIT_DONT_WRITE_MEMORY, SHAPESHIFT_TRAIT) // If you shapeshift into a pet subtype we don't want to update Poly's deathcount or something when you die

	// Make sure that if you shapechanged into a bot, the AI can't just turn you off.
	var/mob/living/simple_animal/bot/polymorph_bot = new_shape
	if (istype(polymorph_bot))
		polymorph_bot.bot_cover_flags |= BOT_COVER_EMAGGED
		polymorph_bot.bot_mode_flags &= ~BOT_MODE_REMOTE_ENABLED

	do_post_shapeshift_adjustments(caster, new_shape)
	return new_shape

/datum/action/cooldown/spell/shapeshift/transformation/do_unshapeshift(mob/living/carbon/caster, skip_animation = FALSE)
	if(caster.transformation_timer || HAS_TRAIT(caster, TRAIT_NO_TRANSFORM))
		caster.balloon_alert(caster, "can't transform!")
		return
	if(!skip_animation)
		do_shapeshift_animation(caster)
	if(caster.body_position == LYING_DOWN) // User might stand up during animation.
		caster.balloon_alert(caster, "must stand up!")
		shapeshift_type = null
		return

	var/datum/status_effect/shapechange_mob/shapechange = caster.has_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera)
	if(!shapechange)
		// We made it to do_unshapeshift without having a shapeshift status effect, this shouldn't happen.
		to_chat(caster, span_warning("You can't un-shapeshift from this form!"))
		stack_trace("[type] do_unshapeshift was called when the mob wasn't even shapeshifted (from a spell).")
		return

	// Restore the requirements.
	spell_requirements = pre_shift_requirements
	pre_shift_requirements = null

	var/mob/living/unshapeshifted_mob = shapechange.caster_mob
	caster.remove_status_effect(/datum/status_effect/shapechange_mob/from_spell/fera)

	shapeshift_type = null
	do_post_shapeshift_adjustments(caster, unshapeshifted_mob)
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
	return

#undef TEMPORARY_TRANSFORMATION_TRAIT
#undef TRANSFORMATION_DURATION
