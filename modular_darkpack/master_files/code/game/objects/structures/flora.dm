/obj/structure/flora
	/// How much fuel this provides to fires on its turf
	var/fuel_power = 4 // TURF_FIRE

/obj/structure/flora/tree
	fuel_power = 1 // trees are more resistant to fire and take much longer to burn // TURF_FIRE

/obj/structure/flora/rock
	fuel_power = 0 // TURF_FIRE
