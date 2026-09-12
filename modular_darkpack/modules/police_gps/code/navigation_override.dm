/mob/living/create_navigation(atom/direct_target = null)
	if(!direct_target)
		return ..()

	if(incapacitated)
		return
	if(length(client.navigation_images))
		addtimer(CALLBACK(src, PROC_REF(cut_navigation)), world.tick_lag)
		balloon_alert(src, "navigation path removed")
		return
	if(!COOLDOWN_FINISHED(src, navigate_cooldown))
		balloon_alert(src, "navigation on cooldown!")
		return

	var/atom/navigate_target = direct_target
	var/finding_zchange = FALSE
	COOLDOWN_START(src, navigate_cooldown, 5 SECONDS)
	if(isatom(navigate_target) && navigate_target.z != z)
		COOLDOWN_START(src, navigate_cooldown, 5 SECONDS)
		var/atom/new_target = find_nearest_stair_or_ladder(get_dir_multiz(src, navigate_target) & (UP|DOWN))
		if(!new_target)
			balloon_alert(src, "can't find ladder or staircase going there!")
			return
		navigate_target = new_target
		finding_zchange = TRUE

	var/list/path = get_path_to(src, navigate_target, 0, mintargetdist = 1, access = get_access(), skip_first = FALSE)
	if(!length(path))
		balloon_alert(src, "can't access the destination!")
		return
	path |= get_turf(navigate_target)
	for(var/i in 1 to length(path))
		var/turf/current_turf = path[i]
		var/image/path_image = image(icon = 'icons/effects/navigation.dmi', layer = HIGH_PIPE_LAYER, loc = current_turf)
		SET_PLANE(path_image, GAME_PLANE, current_turf)
		path_image.color = COLOR_CYAN
		path_image.alpha = 0
		var/dir_1 = 0
		var/dir_2 = 0
		if(i == 1)
			dir_2 = REVERSE_DIR(angle2dir(get_angle(path[i+1], current_turf)))
		else if(i == length(path))
			dir_2 = REVERSE_DIR(angle2dir(get_angle(path[i-1], current_turf)))
		else
			dir_1 = REVERSE_DIR(angle2dir(get_angle(path[i+1], current_turf)))
			dir_2 = REVERSE_DIR(angle2dir(get_angle(path[i-1], current_turf)))
			if(dir_1 > dir_2)
				dir_1 = dir_2
				dir_2 = REVERSE_DIR(angle2dir(get_angle(path[i+1], current_turf)))
		path_image.icon_state = "[dir_1]-[dir_2]"
		client.images += path_image
		client.navigation_images += path_image
		animate(path_image, 0.5 SECONDS, alpha = 150)
	addtimer(CALLBACK(src, PROC_REF(shine_navigation)), 0.5 SECONDS)
	RegisterSignal(src, COMSIG_LIVING_DEATH, PROC_REF(cut_navigation))
	if(finding_zchange)
		RegisterSignal(src, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(cut_navigation))
	balloon_alert(src, "navigation path created")
