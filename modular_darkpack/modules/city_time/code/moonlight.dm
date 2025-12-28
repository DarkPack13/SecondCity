// The primary reasn for it being an element is to prevent signal overlap with lazy fishing but also acts to make it a bit easier to manage behavoir.
/datum/element/moonlight
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

/datum/element/moonlight/Attach(turf/target)
	. = ..()

	if(!isturf(target))
		return ELEMENT_INCOMPATIBLE
	//if(target.light_on)
	//	return ELEMENT_INCOMPATIBLE

	GLOB.starlight += target
	target.set_light(l_on = TRUE, l_range = GLOB.starlight_range, l_power = GLOB.starlight_power, l_color = GLOB.starlight_color)
	RegisterSignal(target, COMSIG_TURF_CHANGE, PROC_REF(clear_moonlight))

/datum/element/moonlight/Detach(turf/target)
	. = ..()
	clear_moonlight(target)

/datum/element/moonlight/proc/clear_moonlight(turf/target)
	SIGNAL_HANDLER

	GLOB.starlight -= target
	UnregisterSignal(target, COMSIG_TURF_CHANGE)

// Adds around a full minute to load westfield mall on my machine. Not optimal
/*
/turf/open/openspace/Initialize(mapload)
	. = ..()
	add_moonlight()
*/

/turf/open/misc/Initialize(mapload)
	. = ..()
	add_moonlight()

/turf/open/floor/Initialize(mapload)
	. = ..()
	add_moonlight()

/turf/open/water/Initialize(mapload)
	. = ..()
	add_moonlight()

/turf/open/proc/add_moonlight()
	if(light_power && light_range) // We likely already have our own pretty lights that I dont want to override
		return
	var/area/my_area = loc
	if(my_area.outdoors)
		AddElement(/datum/element/moonlight)
