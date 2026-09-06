SUBSYSTEM_DEF(police_gps)
	name = "Police GPS"
	wait = 5 MINUTES
	priority = FIRE_PRIORITY_DEFAULT

	var/list/wanted

/datum/controller/subsystem/police_gps/Initialize(start_timeofday)
	wanted = list()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/police_gps/fire()
	update_alert()

/datum/controller/subsystem/police_gps/proc/update_alert()
	set waitfor = FALSE
	for(var/mob/living/carbon/human/officer in GLOB.human_list)
		if(!officer.ignores_warrant)
			continue
		if(length(wanted))
			officer.throw_alert("police_gps", /atom/movable/screen/alert/police_gps)
		else
			officer.clear_alert("police_gps")

/atom/movable/screen/alert/police_gps
	name = "Police GPS"
	icon_state = "heretic_template"
	var/angle = 0
	var/atom/tracking_target
	var/selected_target = 1
	var/crime_label = ""

/atom/movable/screen/alert/police_gps/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/atom/movable/screen/alert/police_gps/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	angle = null
	tracking_target = null
	selected_target = null
	return ..()

/atom/movable/screen/alert/police_gps/Click()
	if(!..())
		return
	if(!crime_label)
		var/wanted_length = length(SSpolice_gps.wanted)
		if(!wanted_length)
			return
		selected_target += 1
		if(selected_target > wanted_length)
			selected_target = 1
		tracking_target = SSpolice_gps.wanted[selected_target]
	to_chat(owner, span_info("You are now tracking a suspect last seen near [get_area_name(tracking_target)]."))

/atom/movable/screen/alert/police_gps/process(seconds_per_tick)
	if(!owner.mind)
		return

	if(!tracking_target)
		if(!length(SSpolice_gps.wanted))
			qdel(src)
			return
		tracking_target = SSpolice_gps.wanted[1]

	if(!tracking_target)
		qdel(src)

	var/turf/target_location = get_turf(tracking_target)
	var/turf/our_location = get_turf(owner)
	if(!target_location || !our_location)
		icon_state = "cult_sense"
		desc = "You have lost the GPS signal."
		return
	desc = crime_label ? "Tracking [crime_label] report in [get_area_name(target_location)]." : "You are tracking [tracking_target] in [get_area_name(tracking_target)]."

	var/target_angle = get_angle(our_location, target_location)
	var/target_dist = get_dist(target_location, our_location)
	cut_overlays()
	switch(target_dist)
		if(0 to 1)
			icon_state = "runed_sense2"
			if(!length(SSpolice_gps.wanted)) // if there are warranted peeps (mass murderers) dont clear the alert
				addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, clear_alert), "police_gps"), 10 SECONDS)
				to_chat(owner, span_info("You have reached your destination."))
		if(2 to 8)
			icon_state = "arrow8"
		if(9 to 15)
			icon_state = "arrow7"
		if(16 to 22)
			icon_state = "arrow6"
		if(23 to 29)
			icon_state = "arrow5"
		if(30 to 36)
			icon_state = "arrow4"
		if(37 to 43)
			icon_state = "arrow3"
		if(44 to 50)
			icon_state = "arrow2"
		if(51 to 57)
			icon_state = "arrow1"
		if(58 to 64)
			icon_state = "arrow0"
		if(65 to 400)
			icon_state = "arrow"
	var/difference = target_angle - angle
	angle = target_angle
	if(!difference)
		return
	var/matrix/final = matrix(transform)
	final.Turn(difference)
	animate(src, transform = final, time = 5, loop = 0)
