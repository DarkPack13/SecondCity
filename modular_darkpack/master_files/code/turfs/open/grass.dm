
// consider just fully removing these, it overlaps with FOOTSTEP_GRASS very hard
//	footstep = FOOTSTEP_TRAVA
//	barefootstep = FOOTSTEP_TRAVA

/turf/open/misc/grass
	//icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	//icon_state = "grass1"

	baseturfs = /turf/open/misc/dirt
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/grass/Initialize(mapload)
	. = ..()
	// icon_state = "grass[rand(1, 3)]"
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			//initial_gas_mix = WINTER_DEFAULT_ATMOS
			//icon_state = "snow[rand(1, 14)]"
			new /obj/effect/decal/snow_overlay(src)
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW
