/obj/structure/ladder/manhole
	icon = 'icons/wod13/props.dmi'
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	travel_time = 5 SECONDS
	travel_sound = 'sound/wod13/manhole.ogg'
	requires_friend = TRUE
	static_apperance = TRUE

/obj/structure/ladder/manhole/up
	name = "ladder"
	icon_state = "ladder"
	base_icon_state = "ladder"
	connect_down = FALSE

/obj/structure/ladder/manhole/down
	name = "manhole"
	icon_state = "manhole"
	base_icon_state = "manhole"
	connect_up = FALSE

/obj/structure/ladder/manhole/down/Initialize(mapload)
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[base_icon_state]-snow"
