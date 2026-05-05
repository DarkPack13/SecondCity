/mob/living/update_ambience_area(area/new_area)
	. = ..()
	if(!client)
		return
	var/atom/movable/screen/area_text/T = new()
	client.screen += T
	T.maptext = MAPTEXT({"<span style='font-size: 200%; text-shadow: 1px 1px 2px black, 0 0 1em black, 0 0 0.2em black; display: block; text-align: center;'>[entered_area.name]</span>"})
	animate(T, alpha = 255, time = 10, easing = EASE_IN)
	addtimer(CALLBACK(src, PROC_REF(clear_area_text), T), 35)

// this shouldnt be here since its not an override or a subtype of a /tg/ proc (like above) but since it's called right there i figured i'd keep things together.
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
