/area
	var/fire_controled = FALSE
	var/fire_controling = FALSE

	// START - AMBIENCE
	var/music_index
	/// Equivelent to ambientsounds, A list of music tracks to pick from every so often to play to clients.
	var/list/musictracks
	///Does this area immediately play a music track upon enter?
	var/forced_music = FALSE
	///Used to decide what the minimum time between music tracks is
	var/min_music_cooldown = 1 MINUTES
	///Used to decide what the maximum time between music tracks is
	var/max_music_cooldown = 2 MINUTES
	// END - AMBIENCE

/area/Initialize(mapload)
	// START - AMBIENCE
	if(!musictracks)
		musictracks = GLOB.music_assoc[music_index]
	// END - AMBIENCE

	. = ..()

/area/Entered(atom/movable/arrived, area/old_area)
	set waitfor = FALSE
	SEND_SIGNAL(src, COMSIG_AREA_ENTERED, arrived, old_area)

	if(!arrived.important_recursive_contents?[RECURSIVE_CONTENTS_AREA_SENSITIVE])
		return
	for(var/atom/movable/recipient as anything in arrived.important_recursive_contents[RECURSIVE_CONTENTS_AREA_SENSITIVE])
		SEND_SIGNAL(recipient, COMSIG_ENTER_AREA, src)

	if(ismob(arrived))
		var/mob/living/mob = arrived
		mob.update_ambience_area(src)
		if(mob.client)
			var/atom/movable/screen/area_text/T = new()
			mob.client.screen += T
			T.maptext = MAPTEXT({"<span style='font-size: 200%; text-shadow: 1px 1px 2px black, 0 0 1em black, 0 0 0.2em black;'>[name]</span>"})
			animate(T, alpha = 255, time = 10, easing = EASE_IN)
			addtimer(CALLBACK(mob, TYPE_PROC_REF(/mob/living, clear_area_text), T), 35)

/mob/living/proc/clear_area_text(atom/movable/screen/A)
	if(!A)
		return
	if(!client)
		return
	animate(A, alpha = 0, time = 10, easing = EASE_OUT)
	sleep(11)
	if(client)
		if(client.screen && A)
			client.screen -= A
	qdel(A)
