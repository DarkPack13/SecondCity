/mob/living/proc/melee_swing(visual_effect = /obj/effect/temp_visual/dir_setting/swing_effect)
	changeNext_move(CLICK_CD_RANGE)
	new visual_effect(get_turf(src), dir)
	playsound(loc, 'modular_darkpack/modules/combat/sounds/swing.ogg', 50, TRUE)
	var/atom/hit_target
	var/turf/center_turf = get_step(src, dir)
	var/turf/left_turf = get_step(center_turf, turn(dir, -90))
	var/turf/right_turf = get_step(center_turf, turn(dir, 90))

	for(var/turf/swung_turf in list(center_turf, left_turf, right_turf))
		hit_target = locate(/mob/living) in swung_turf
		if(hit_target)
			break
	if(!hit_target)
		for(var/obj/swung_object in center_turf)
			if(swung_object.obj_flags & CAN_BE_HIT)
				hit_target = swung_object
				break

	// Originally this was in front of searching for turfs but SURELY you would want this after you get a target. Right?
	SEND_SIGNAL(src, COMSIG_LIVING_MELEE_SWING, hit_target, center_turf, left_turf, right_turf)

	if(hit_target)
		changeNext_move(CLICK_CD_MELEE)
		return hit_target

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

/datum/config_entry/flag/swing_combat
