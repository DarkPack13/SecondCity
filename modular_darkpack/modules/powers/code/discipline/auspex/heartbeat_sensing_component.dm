// The entire component is an edited version of TG's echolocation component. If that has any changes done, please apply them accordingly to this file.

/datum/component/heartbeat_sensing
	/// Radius of our view.
	var/range = 4
	/// Time between sensing. IMPORTANT!! The effective time in local and the effective time in live are very different. The second is noticeably slower,
	var/cooldown_time = 1 SECONDS
	/// Time for the image to start fading out.
	var/image_expiry_time = 0.7 SECONDS
	/// Time for the image to fade in.
	var/fade_in_time = 0.2 SECONDS
	/// Time for the image to fade out and delete itself.
	var/fade_out_time = 0.3 SECONDS
	/// Are images static? If yes, spawns them on the turf and makes them not change location. Otherwise they change location and pixel shift with the original.
	var/images_are_static = TRUE
	/// This trait blocks us from receiving heartbeat_sensing.
	var/blocking_trait
	/// Ref of the client color we give to the parent.
	var/client_colour
	/// Associative list of receivers to lists of atoms they are rendering (those atoms are associated to data of the image and time they were rendered at).
	var/list/receivers = list()
	/// All the saved appearances, keyed by icon-icon_state.
	var/static/list/saved_appearances = list()
	/// Typecache of all the allowed paths to render.
	var/static/list/allowed_paths
	/// Typecache of turfs that are dangerous, to give them a special icon.
	var/static/list/danger_turfs
	/// A matrix that turns everything except #ffffff into pure blackness, used for our images (the outlines are #ffffff).
	var/static/list/black_white_matrix = list(85, 85, 85, 0, 85, 85, 85, 0, 85, 85, 85, 0, 0, 0, 0, 1, -254, -254, -254, 0)
	/// A matrix that turns everything into pure white.
	var/static/list/white_matrix = list(255, 255, 255, 0, 255, 255, 255, 0, 255, 255, 255, 0, 0, 0, 0, 1, 0, 0, 0, 0)
	/// Cooldown for the heartbeat_sensing.
	COOLDOWN_DECLARE(cooldown_last)

/datum/component/heartbeat_sensing/Initialize(range, cooldown_time, image_expiry_time, fade_in_time, fade_out_time, images_are_static, blocking_trait, echo_icon, color_path)
	. = ..()
	var/mob/living/parent = parent
	if(!istype(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(range))
		src.range = range
	if(!isnull(cooldown_time))
		src.cooldown_time = cooldown_time
	if(!isnull(image_expiry_time))
		src.image_expiry_time = image_expiry_time
	if(!isnull(fade_in_time))
		src.fade_in_time = fade_in_time
	if(!isnull(fade_out_time))
		src.fade_out_time = fade_out_time
	if(!isnull(images_are_static))
		src.images_are_static = images_are_static
	if(!isnull(blocking_trait))
		src.blocking_trait = blocking_trait
	if(ispath(color_path))
		client_colour = parent.add_client_colour(color_path, "heartbeat_sensor")
	START_PROCESSING(SSfastprocess, src)

/datum/component/heartbeat_sensing/Destroy(force)
	STOP_PROCESSING(SSfastprocess, src)
	var/mob/living/parent = parent
	QDEL_NULL(client_colour)
	for(var/mob/living/echolocate_receiver as anything in receivers)
		if(!echolocate_receiver.client)
			continue
		for(var/atom/rendered_atom as anything in receivers[echolocate_receiver])
			echolocate_receiver.client.images -= receivers[heartbeat_sensing_mob][rendered_atom]["image"]
		receivers -= list(heartbeat_sensing_mob)
	return ..()

/datum/component/heartbeat_sensing/process()
	var/mob/living/parent = parent
	if(parent.stat == DEAD)
		return
	echolocate()

/datum/component/heartbeat_sensing/proc/echolocate()
	if(!COOLDOWN_FINISHED(src, cooldown_last))
		return
	COOLDOWN_START(src, cooldown_last, cooldown_time)
	var/mob/living/parent = parent
	var/real_range = range
	if(HAS_TRAIT(parent, TRAIT_heartbeat_sensing_EXTRA_RANGE))
		real_range += 2
	var/list/filtered = list()
	var/list/seen = dview(real_range, get_turf(parent.client?.eye || parent), invis_flags = parent.see_invisible)
	if(blinding)
		for(var/atom/seen_atom as anything in seen)
			if(!seen_atom.alpha)
				continue
			if(allowed_paths[seen_atom.type])
				filtered += seen_atom
	else
		var/list/ranged_atoms = range(real_range, get_turf(parent.client?.eye || parent))
		for(var/atom/possible_atom as anything in ranged_atoms)
			if(!possible_atom.alpha)
				continue
			if(allowed_paths[possible_atom.type])
				filtered += possible_atom
	if(!length(filtered))
		return
	var/current_time = "[world.time]"
	for(var/mob/living/viewer in filtered)
		if(blocking_trait && HAS_TRAIT(viewer, blocking_trait))
			continue
	for(var/atom/filtered_atom as anything in filtered)
		show_image(saved_appearances["[filtered_atom.icon]-[filtered_atom.icon_state]"] || generate_appearance(filtered_atom), filtered_atom, current_time)
	addtimer(CALLBACK(src, PROC_REF(fade_images), current_time), image_expiry_time)

/datum/component/heartbeat_sensing/proc/show_image(image/input_appearance, atom/input, current_time)
	var/image/final_image = image(input_appearance)
	final_image.layer += EFFECTS_LAYER
	final_image.plane = FULLSCREEN_PLANE
	final_image.loc = images_are_static ? get_turf(input) : input
	final_image.dir = input.dir
	final_image.alpha = 0
	if(images_are_static)
		final_image.pixel_x = input.pixel_x
		final_image.pixel_y = input.pixel_y
	var/list/fade_ins = list(final_image)
	for(var/mob/living/heartbeat_sensing_mob as anything in receivers)
		if(heartbeat_sensing_mob == input)
			continue
		if(receivers[heartbeat_sensing_mob][input])
			var/previous_image = receivers[heartbeat_sensing_mob][input]["image"]
			fade_ins |= previous_image
			receivers[heartbeat_sensing_mob][input] = list("image" = previous_image, "time" = current_time)
		else
			if(heartbeat_sensing_mob.client)
				heartbeat_sensing_mob.client.images += final_image
			receivers[heartbeat_sensing_mob][input] = list("image" = final_image, "time" = current_time)
	for(var/image_echo in fade_ins)
		animate(image_echo, alpha = 255, time = fade_in_time)

/datum/component/heartbeat_sensing/proc/generate_appearance(atom/input)
	var/use_outline = TRUE
	var/mutable_appearance/copied_appearance = new /mutable_appearance()
	copied_appearance.appearance = input
	if(istype(input, /obj/machinery/door/airlock)) //i hate you
		copied_appearance.cut_overlays()
		copied_appearance.icon_state = "closed"
	else if(danger_turfs[input.type])
		copied_appearance.icon = 'icons/turf/floors.dmi'
		copied_appearance.icon_state = "danger"
		use_outline = FALSE
	copied_appearance.color = black_white_matrix
	if(use_outline)
		copied_appearance.filters += outline_filter(size = 1, color = COLOR_WHITE)
	if(!images_are_static)
		copied_appearance.pixel_x = 0
		copied_appearance.pixel_y = 0
		copied_appearance.transform = matrix()
	if(input.icon && input.icon_state)
		saved_appearances["[input.icon]-[input.icon_state]"] = copied_appearance
	return copied_appearance

/datum/component/heartbeat_sensing/proc/fade_images(from_when)
	var/fade_outs = list()
	for(var/mob/living/heartbeat_sensing_mob as anything in receivers)
		for(var/atom/rendered_atom as anything in receivers[heartbeat_sensing_mob])
			if(receivers[heartbeat_sensing_mob][rendered_atom]["time"] <= from_when)
				fade_outs |= receivers[heartbeat_sensing_mob][rendered_atom]["image"]
	for(var/image_echo in fade_outs)
		animate(image_echo, alpha = 0, time = fade_out_time)
	addtimer(CALLBACK(src, PROC_REF(delete_images), from_when), fade_out_time)

/datum/component/heartbeat_sensing/proc/delete_images(from_when)
	for(var/mob/living/heartbeat_sensing_mob as anything in receivers)
		for(var/atom/rendered_atom as anything in receivers[heartbeat_sensing_mob])
			if(receivers[heartbeat_sensing_mob][rendered_atom]["time"] <= from_when && heartbeat_sensing_mob.client)
				heartbeat_sensing_mob.client.images -= receivers[heartbeat_sensing_mob][rendered_atom]["image"]
				receivers[heartbeat_sensing_mob] -= rendered_atom
		if(!length(receivers[echolocate_receiver]))
			receivers -= echolocate_receiver

/atom/movable/screen/fullscreen/hearbeat
	icon_state = "echo"
	layer = ECHO_LAYER
	show_when_dead = TRUE

/atom/movable/screen/fullscreen/hearbeat/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	particles = new /particles/echo()

/atom/movable/screen/fullscreen/hearbeat/Destroy()
	QDEL_NULL(particles)
	return ..()
