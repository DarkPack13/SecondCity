/// Called by throw_alert(), passes the mob throw_alert() is being called on as an arg. Parent proc, does nothing.
/atom/movable/screen/alert/proc/alert_post_setup(mob/user)
	return

/atom/movable/screen/alert/multi_z
	name = "Look Up"
	desc = "There's an open space above you, Click the alert to look up."
	icon_state = "uphint1"
	icon = 'modular_darkpack/modules/hud/icons/screen_alert.dmi'
	click_master = FALSE


/atom/movable/screen/alert/multi_z/Click(location, control, params)
	. = ..()
	if(!.)
		return

	var/list/modifiers = params2list(params)
	var/mob/living/living_owner = owner
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		living_owner.look_down()
	else
		living_owner.look_up()


/atom/movable/screen/alert/multi_z/alert_post_setup(mob/user)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(update_alert))
	update_alert(user)

/atom/movable/screen/alert/multi_z/proc/update_alert(mob/living/user)
	// No user, no update.
	if(!user)
		return

	// If the user's not on a turf we can skip this.
	if(!isturf(user.loc))
		return

	// Check if owner's current Z has the "up" ztrait; if not, hide the indicator.
	if(!user.z || !(is_multi_z_level(user.z)))
		icon_state = "blank"
		return

	// Get the turf on the level above the user.
	var/turf/above = get_looking_turf(user)

	if(above)
		icon_state = "uphint1"
		desc = "There's an open space above you, Click the alert to look up."
	else
		icon_state = "uphint0"
		desc = "There's nothing to look up at right now."


/atom/movable/screen/alert/multi_z/proc/get_looking_turf(mob/living/user)
	//down needs to check this floor
	var/turf/check_turf = get_step_multiz(user, UP)
	if(!get_step_multiz(user, UP)) //We are at the edge z-level.
		return
	else if(!istransparentturf(check_turf)) //There is no turf we can look through above us
		var/turf/front_hole = get_step(check_turf, user.dir)
		if(istransparentturf(front_hole))
			check_turf = front_hole
		else
			for(var/turf/checkhole in TURF_NEIGHBORS(check_turf))
				if(istransparentturf(checkhole))
					check_turf = checkhole
					break
		if(!istransparentturf(check_turf))
			return
	return check_turf
