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

/turf/open/extinguish_turf(cooling_power = 2)
	if(!air)
		return
	if(!active_hotspot && !turf_fire)
		return
	//air.set_temperature(max(min(air.return_temperature() - (cooling_power * 1000), air.return_temperature() / cooling_power), TCMB))
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

/turf/open/misc/grass/dirt/burn_tile()
	return FALSE

/turf/open/floor/wood
	flammability = 2
