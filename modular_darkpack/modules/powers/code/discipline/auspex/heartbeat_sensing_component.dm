/datum/component/heartbeat_sensing
	/// Time between heartbeat sensings. IMPORTANT!! The effective time in local and the effective time in live are very different. The second is noticeably slower.
	var/cooldown_time = 1 SECONDS
	/// Time for the image to start fading out.
	var/image_expiry_time = 0.7 SECONDS
	/// Time for the image to fade in.
	var/fade_in_time = 0.2 SECONDS
	/// Time for the image to fade out and delete itself.
	var/fade_out_time = 0.3 SECONDS
	/// Ref of the client color we give to the parent.
	var/client_colour
	/// A matrix that turns everything except #ffffff into pure blackness, used for our images (the outlines are #ffffff).
	var/static/list/black_white_matrix = list(85, 85, 85, 0, 85, 85, 85, 0, 85, 85, 85, 0, 0, 0, 0, 1, -254, -254, -254, 0)
	/// A matrix that turns everything into pure white.
	var/static/list/white_matrix = list(255, 255, 255, 0, 255, 255, 255, 0, 255, 255, 255, 0, 0, 0, 0, 1, 0, 0, 0, 0)
	/// Cooldown for the heartbeat sensing.
	COOLDOWN_DECLARE(cooldown_last)

/datum/component/heartbeat_sensing/Initialize(cooldown_time, image_expiry_time, fade_in_time, fade_out_time, color_path)
	. = ..()
	var/mob/living/parent_mob = parent
	if(!istype(parent_mob))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(cooldown_time))
		src.cooldown_time = cooldown_time
	if(!isnull(image_expiry_time))
		src.image_expiry_time = image_expiry_time
	if(!isnull(fade_in_time))
		src.fade_in_time = fade_in_time
	if(!isnull(fade_out_time))
		src.fade_out_time = fade_out_time
	if(ispath(color_path))
		client_colour = parent_mob.add_client_colour(color_path, "heartbeat_sensing_colour")
	START_PROCESSING(SSfastprocess, src)

/datum/component/heartbeat_sensing/Destroy(force)
	STOP_PROCESSING(SSfastprocess, src)
	QDEL_NULL(client_colour)
	return ..()

/datum/component/heartbeat_sensing/process()
	var/mob/living/parent_mob = parent
	if(parent_mob.stat == DEAD)
		return
	sense_heartbeat()

/datum/component/heartbeat_sensing/proc/sense_heartbeat()
	if(!COOLDOWN_FINISHED(src, cooldown_last))
		return
	COOLDOWN_START(src, cooldown_last, cooldown_time)
	var/mob/living/parent_mob = parent
	for(var/mob/living/living_mob in orange(parent_mob.view, get_turf(parent_mob)))
		var/obj/item/organ/heart/beating_heart = living_mob.get_organ_slot(ORGAN_SLOT_HEART)
		if(!istype(beating_heart) && !(beating_heart.is_beating()))
			continue
		show_heartbeat_image(living_mob)

/datum/component/heartbeat_sensing/proc/show_heartbeat_image(mob/living_mob)
	show_image(saved_appearances["[filtered_atom.icon]-[filtered_atom.icon_state]"] || generate_appearance(filtered_atom), filtered_atom, current_time)
	addtimer(CALLBACK(src, PROC_REF(fade_images), current_time), image_expiry_time)
