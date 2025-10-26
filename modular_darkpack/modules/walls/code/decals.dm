/obj/effect/decal/coastline
	name = "water"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "coastline"

/obj/effect/decal/coastline/corner
	icon_state = "coastline_corner"

/obj/effect/decal/shadow
	name = "shadow"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "shadow"

/obj/effect/decal/shadow/Initialize(mapload)
	. = ..()
	if(istype(loc, /turf/open/openspace))
		forceMove(get_step(src, NORTH))
		pixel_y = -32

/obj/effect/decal/support
	name = "support"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "support"
