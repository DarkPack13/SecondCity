/obj/effect/turf_decal/asphalt
	name = "asphalt"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "decal1"
	mouse_opacity = 0

/obj/effect/turf_decal/asphalt/Initialize(mapload)
	. = ..()
	icon_state = "decal[rand(1, 24)]"
	update_icon()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				alpha = 25

/obj/effect/decal/snow_overlay
	name = "snow"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "snow_overlay"
	alpha = 200
	mouse_opacity = 0

/obj/effect/turf_decal/asphaltline
	name = "asphalt"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "line"
	mouse_opacity = 0
	layer = TURF_DECAL_LAYER

/obj/effect/turf_decal/asphaltline/alt
	icon_state = "line_alt"

/obj/effect/turf_decal/asphaltline/Initialize(mapload)
	. = ..()
	icon_state = "[initial(icon_state)][rand(1, 3)]"
	update_icon()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)][rand(1, 3)]-snow"

/obj/effect/turf_decal/crosswalk
	name = "asphalt"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "crosswalk1"
	mouse_opacity = 0

/obj/effect/turf_decal/crosswalk/Initialize(mapload)
	. = ..()
	icon_state = "crosswalk[rand(1, 3)]"
	update_icon()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "crosswalk[rand(1, 3)]-snow"

/obj/effect/turf_decal/stock
	name = "stock"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "stock"
	mouse_opacity = 0

/obj/effect/turf_decal/bordur
	name = "sidewalk"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "border"
	mouse_opacity = 0

/obj/effect/turf_decal/bordur/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"
//				footstep = FOOTSTEP_SNOW
//				barefootstep = FOOTSTEP_SNOW
//				clawfootstep = FOOTSTEP_SNOW
//				heavyfootstep = FOOTSTEP_SNOW

/obj/effect/turf_decal/bordur/corner
	icon_state = "border_corner"
