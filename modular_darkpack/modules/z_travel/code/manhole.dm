/obj/structure/ladder/manhole
	icon = 'modular_darkpack/modules/z_travel/icons/z_travel.dmi'
	icon_state = "manhole"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	travel_time = 5 SECONDS
	travel_sound = 'modular_darkpack/modules/z_travel/sounds/manhole.ogg'
	requires_friend = TRUE
	static_appearance = TRUE

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
	if(HAS_TRAIT(SSstation, STATION_TRAIT_INFESTATION))
		AddComponent(\
			/datum/component/spawner,\
			spawn_types = list(/mob/living/basic/mouse/vampire),\
			spawn_time = 15 MINUTES,\
			max_spawned = 1,\
			spawn_text = "crawls out from",\
		)

	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[base_icon_state]-snow"
