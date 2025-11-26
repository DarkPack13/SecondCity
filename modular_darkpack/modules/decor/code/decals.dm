/obj/effect/decal/snow_overlay
	name = "snow"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "snow_overlay"
	alpha = 200
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/decal/coastline
	name = "water"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "coastline"

/obj/effect/decal/coastline/corner
	icon_state = "coastline_corner"

/obj/effect/decal/shadow
	name = "shadow"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "shadow"

/obj/effect/decal/shadow/Initialize(mapload)
	. = ..()
	if(istype(loc, /turf/open/openspace))
		forceMove(get_step(src, NORTH))
		pixel_y = -32

/obj/effect/decal/shadow/low
	icon_state = "shadow_low"

/obj/effect/decal/support
	name = "support"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "support"

/obj/effect/decal/rugs
	name = "rugs"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "rugs"

/obj/effect/decal/rugs/Initialize(mapload)
	. = ..()
	icon_state = "rugs[rand(1, 11)]"

// Turf decals, init behavoir is all before the parent call as the parent call is what bakes them into the turf so icon updates need to happen before that.

/obj/effect/turf_decal/asphalt
	name = "asphalt"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "decal1"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/turf_decal/asphalt/Initialize(mapload)
	icon_state = "decal[rand(1, 24)]"
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			alpha = 25
	. = ..()

/obj/effect/turf_decal/asphaltline
	name = "asphalt"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "line"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = TURF_DECAL_LAYER

/obj/effect/turf_decal/asphaltline/alt
	icon_state = "line_alt"

/obj/effect/turf_decal/asphaltline/Initialize(mapload)
	icon_state = "[initial(icon_state)][rand(1, 3)]"
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)][rand(1, 3)]-snow"
	. = ..()

/obj/effect/turf_decal/crosswalk
	name = "asphalt"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "crosswalk1"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/turf_decal/crosswalk/Initialize(mapload)
	icon_state = "crosswalk[rand(1, 3)]"
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "crosswalk[rand(1, 3)]-snow"
	. = ..()

/obj/effect/turf_decal/stock
	name = "stock"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "stock"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/turf_decal/bordur
	name = "sidewalk"
	icon = 'modular_darkpack/modules/decor/icons/decals.dmi'
	icon_state = "border"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/turf_decal/bordur/Initialize(mapload)
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"
	. = ..()

/obj/effect/turf_decal/bordur/corner
	icon_state = "border_corner"
