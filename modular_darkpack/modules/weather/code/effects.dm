GLOBAL_LIST_EMPTY(rain_list)
GLOBAL_LIST_EMPTY(fog_list)
GLOBAL_LIST_EMPTY(snow_list)

/obj/effect/realistic_fog
	icon = 'modular_darkpack/modules/weather/icons/fog.dmi'
	icon_state = "fog"
	alpha = 0
	plane = GAME_PLANE
	layer = SPACEVINE_LAYER
	anchored = TRUE
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pixel_w = -96
	pixel_z = -96

/obj/effect/realistic_fog/Initialize(mapload)
	. = ..()
	animate(src, pixel_x = rand(-96, 96), pixel_y = rand(-96, 96), alpha = rand(5, 21), transform = matrix()*rand(1, 3), transform = turn(matrix(), rand(0, 360)), time = rand(100, 200), loop = -1)
	animate(transform = null, pixel_x = 0, pixel_y = 0, alpha = rand(5, 21), time = rand(100, 200))

/obj/effect/realistic_fog/Destroy(force)
	GLOB.fog_list -= src
	. = ..()

/obj/effect/new_rain
	icon = 'modular_darkpack/modules/weather/icons/newweather.dmi'
	icon_state = "rain1"
	alpha = 0
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pixel_w = -16
	pixel_z = -32

/obj/effect/new_rain/Initialize(mapload)
	. = ..()
	icon_state = "rain[rand(1, 15)]"
	var/matrix/M = new
	M.Scale(0.5, 0.5)
	transform = M
	animate(src, alpha = 64, time = 30)

/obj/effect/new_rain/Destroy(force)
	GLOB.rain_list -= src
	. = ..()

/obj/effect/new_rain/Cross(atom/movable/crossed_atom)
	. = ..()
	if(isitem(crossed_atom) || isliving(crossed_atom))
		crossed_atom.wash(CLEAN_WASH)

/obj/effect/new_snow
	icon = 'modular_darkpack/modules/weather/icons/newweather.dmi'
	icon_state = "snow1"
	alpha = 0
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pixel_w = -16

/obj/effect/new_snow/Initialize(mapload)
	. = ..()
	icon_state = "snow[rand(1, 15)]"
	animate(src, alpha = 128, time = 30)

/obj/effect/new_snow/Destroy(force)
	GLOB.snow_list -= src
	. = ..()

/area/proc/fog_setup()
	for(var/turf/open/O in src)
		var/obj/effect/realistic_fog/F = new(O)
		GLOB.fog_list += F
		CHECK_TICK // All of these are admin proc calls atm so this is fine. If its moved to any type of subsystem remove this

/area/proc/rain_setup()
	for(var/turf/open/O in src)
		var/obj/effect/new_rain/R = new(O)
		GLOB.rain_list += R
		CHECK_TICK // All of these are admin proc calls atm so this is fine. If its moved to any type of subsystem remove this

/area/proc/snow_setup()
	for(var/turf/open/O in src)
		var/obj/effect/new_snow/S = new(O)
		GLOB.snow_list += S
		CHECK_TICK // All of these are admin proc calls atm so this is fine. If its moved to any type of subsystem remove this
