/obj/structure/flora
	/// How much fuel this provides to fires on its turf
	var/fuel_power = 4

/obj/structure/flora/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	var/turf/open/plant_turf = get_turf(src)
	if(isopenturf(plant_turf) && prob(plant_turf.flammability >= 1))
		plant_turf.ignite_turf(fuel_power + plant_turf.flammability)

/obj/structure/flora/tree
	fuel_power = 1 // trees are more resistant to fire and take much longer to burn

/obj/structure/flora/rock
	fuel_power = 0
