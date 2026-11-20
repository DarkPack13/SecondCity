/datum/component/lashing_tail
	COOLDOWN_DECLARE(stab_cooldown)

/datum/component/lashing_tail/Initialize()
	. = ..()
	if(!isliving(parent))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_MOB_CLICKON, PROC_REF(try_stab))

//Ensures that a tailstab can actually be performed
/datum/component/lashing_tail/proc/try_stab(mob/living/stabber, atom/target, list/modifiers)
	SIGNAL_HANDLER

	// completely abort if we are able to jump
	if(!HAS_TRAIT(stabber, TRAIT_JUMPING_BLOCKED))
		return

	//only process if the clicker used left click if prepared, or middle click
	if(!LAZYACCESS(modifiers, MIDDLE_CLICK))
		return

	//only process if shift, ctrl, and alt are NOT being held
	if(LAZYACCESS(modifiers, CTRL_CLICK) || LAZYACCESS(modifiers, SHIFT_CLICK) || LAZYACCESS(modifiers, ALT_CLICK))
		return

	if(IS_UNCONSCIOUS_OR_CRIT(stabber))
		return

//	if(stabber.pulledby && stabber.pulledby.grab_state != GRAB_PASSIVE)
//		return

	if(HAS_TRAIT(stabber, TRAIT_IMMOBILIZED))
		return

	if(HAS_TRAIT(stabber, TRAIT_INCAPACITATED))
		return

	if(HAS_TRAIT(stabber, TRAIT_RESTRAINED))
		return

	if(HAS_TRAIT(stabber, TRAIT_FLOORED))
		return



//	if(stabber.body_position == LYING_DOWN)
//		return

	if(stabber.buckled)
		return

	if(!(stabber.mobility_flags & MOBILITY_MOVE))
		return

	if(!target || !isturf(stabber.loc))
		return

	if(istype(target, /atom/movable/screen))
		return

	if(get_turf(stabber) == get_turf(target)) // We can't stab ourselves
		return

	if(!COOLDOWN_FINISHED(src, stab_cooldown))
		to_chat(stabber, span_notice("You can't stab so soon!"))
		return

	INVOKE_ASYNC(src, PROC_REF(stab), stabber, target)
	return COMSIG_MOB_CANCEL_CLICKON

/datum/component/lashing_tail/proc/stab(mob/living/stabber, atom/target)
	stabber.face_atom(target)

	var/obj/item/ammo_casing/magic/fomor_lashing_tail/casing = new (stabber.loc)
	var/obj/projectile/lashing_tail/proj = casing.loaded_projectile
	proj.firing_mob = stabber
	casing.fire_casing(target, stabber, null, null, null, ran_zone(stabber.zone_selected), 0, fired_from = stabber)
	COOLDOWN_START(src, stab_cooldown, 3 SECONDS)
