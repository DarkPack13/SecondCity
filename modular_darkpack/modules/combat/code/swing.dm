/mob/living/proc/melee_swing(visual_effect, atom/swung_item)
	playsound(loc, 'modular_darkpack/modules/combat/sounds/swing.ogg', 50, TRUE)
	var/atom/hit_target
	var/turf/center_turf = get_step(src, dir)
	var/turf/left_turf = get_step(center_turf, turn(dir, -90))
	var/turf/right_turf = get_step(center_turf, turn(dir, 90))

	for(var/turf/swung_turf in list(center_turf, left_turf, right_turf))
		var/mob/living/living_on_turf = locate() in swung_turf
		if(!living_on_turf)
			continue
		if(living_on_turf.stat == DEAD)
			continue
		hit_target = living_on_turf
		break
	/* // More likely then not, not acctually what your trying to click on. Revisit
	if(!hit_target)
		for(var/obj/swung_object in center_turf)
			if(swung_object.obj_flags & CAN_BE_HIT)
				hit_target = swung_object
				break
	*/

	if(!visual_effect)
		visual_effect = get_swing_visual(hit_target, swung_item)
	new visual_effect(get_turf(src), dir)

	// Originally this was in front of searching for turfs but SURELY you would want this after you get a target. Right?
	SEND_SIGNAL(src, COMSIG_LIVING_MELEE_SWING, hit_target, center_turf, left_turf, right_turf)

	if(hit_target)
		// changeNext_move(CLICK_CD_MELEE)
		return hit_target
	else
		changeNext_move(CLICK_CD_RANGE) // Whiff punish (to avoid people spam clicking and the visuals looking dumb)

/mob/living/proc/get_swing_visual(atom/target, atom/swung_item)
	return /obj/effect/temp_visual/dir_setting/swing_effect

// unarmed_attack_effect = ATTACK_EFFECT_CLAW


/mob/living/carbon/get_swing_visual(atom/target, atom/swung_item)
	. = ..()

	if(!swung_item)
		var/obj/item/bodypart/attacking_bodypart = get_attacking_limb(target)
		if(attacking_bodypart?.unarmed_attack_effect == ATTACK_EFFECT_CLAW)
			return /obj/effect/temp_visual/dir_setting/claw_effect


/obj/item/proc/can_swing()
	// Technicly meant for no flavor text but is semi widly used as a "noncombat" weapon check
	if(!(item_flags & NOBLUDGEON))
		return TRUE

/obj/item/gun/can_swing()
	return FALSE


/obj/effect/temp_visual/dir_setting/swing_effect
	icon = 'modular_darkpack/modules/combat/icons/swing.dmi'
	icon_state = "swing1"
	pixel_w = -32
	pixel_z = -32
	duration = 0.3 SECONDS

/obj/effect/temp_visual/dir_setting/claw_effect
	icon = 'modular_darkpack/modules/combat/icons/swing.dmi'
	icon_state = "claw1"
	pixel_w = -32
	pixel_z = -32
	duration = 0.3 SECONDS


/*!
 * This element allows the mob its attached to the ability to click an adjacent mob by clicking a distant atom
 * that is in the general direction relative to the parent.
 */
/datum/element/swing_attack/Attach(datum/target)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_MOB_ATTACK_RANGED, PROC_REF(on_ranged_attack))

/datum/element/swing_attack/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_MOB_ATTACK_RANGED)

/**
 * This proc handles clicks on tiles that aren't adjacent to the source mob
 * In addition to clicking the distant tile, it checks the tile in the direction and clicks the mob in the tile if there is one
 * Arguments:
 * * source - The mob clicking
 * * clicked_atom - The atom being clicked (should be a distant one)
 * * click_params - Miscellaneous click parameters, passed from Click itself
 */
/datum/element/swing_attack/proc/on_ranged_attack(mob/living/source, atom/clicked_atom, click_params)
	SIGNAL_HANDLER

	if(!source.combat_mode)
		return

	if(!source?.client?.prefs?.read_preference(/datum/preference/toggle/ranged_click_to_melee))
		return

	if(QDELETED(clicked_atom))
		return

	var/obj/item/held_item = source.get_active_held_item()
	if(held_item && !held_item.can_swing())
		return

	var/atom/swing_result = source.melee_swing(swung_item = held_item)
	if(swing_result?.IsReachableBy(source, held_item ? held_item.reach : 1))
		//This is here to undo the +1 the click on the distant turf adds so we can click the mob near us
		source.next_click = world.time - 1
		INVOKE_ASYNC(source, TYPE_PROC_REF(/mob, ClickOn), swing_result, list2params(click_params))
