/turf/proc/ignite_turf(power, fire_color = "red")
	return SEND_SIGNAL(src, COMSIG_TURF_IGNITED, power, fire_color)

/turf/proc/extinguish_turf()
	return

/turf/open
	/// How much fuel this open turf provides to turf fires
	var/flammability = 0.2
	var/obj/effect/abstract/turf_fire/turf_fire

/turf/open/ignite_turf(power, fire_color)
	. = ..()
	if(. & SUPPRESS_FIRE)
		return
	if(turf_fire)
		turf_fire.AddPower(power)
		return
	if(isgroundlessturf(src))
		return
	new /obj/effect/abstract/turf_fire(src, power, fire_color)

/turf/open/extinguish_turf(cooling_power = 1.2)
	if(!air)
		return
	if(!active_hotspot && !turf_fire)
		return
	air.temperature = min(max(min(air.temperature-(cooling_power*1000), air.temperature/cooling_power), T0C), air.temperature) // the outer min temperature check is for weird phenomena like freon combustion
	temperature = clamp(min(temperature-(cooling_power*1000), temperature/cooling_power), T20C, temperature) // turfs normally don't go below T20C so I'll just clamp it to that in case of weird phenomena.
	air.react(src)
	if(active_hotspot)
		qdel(active_hotspot)
	if(turf_fire)
		qdel(turf_fire)

/turf/open/space
	flammability = -INFINITY // not a single chance in hell

/turf/open/water
	flammability = 0

/turf/open/misc/grass
	flammability = 2

/turf/open/misc/grass/burn_tile()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return TRUE

/turf/open/misc/dirt/burn_tile()
	return FALSE

/turf/open/misc/snow
	flammability = 0

/turf/open/floor/wood
	flammability = 2

/turf/open/floor/carpet
	flammability = 2
