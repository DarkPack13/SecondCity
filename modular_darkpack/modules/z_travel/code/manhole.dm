/obj/structure/ladder/manhole
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	travel_time = 3 SECONDS // Big ass manhole cover you have to move.
	requires_friend = TRUE

/obj/structure/ladder/manhole/up
	name = "ladder"
	icon_state = "ladder10"
	base_icon_state = "ladder"
	connect_down = FALSE
	static_appearance = TRUE

/obj/structure/ladder/manhole/down
	name = "manhole"
	icon_state = "manhole_closed"
	base_icon_state = "manhole"
	travel_sound = 'modular_darkpack/modules/z_travel/sounds/manhole.ogg'
	connect_up = FALSE
	static_appearance = TRUE

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

/obj/structure/ladder/manhole/down/start_travelling(mob/user, going_up)
	icon_state = "[base_icon_state]_open"
	. = ..()

/obj/structure/ladder/manhole/down/travel(mob/user, going_up, is_ghost, grant_exp)
	icon_state = "[base_icon_state]_closed"
	. = ..()


/obj/structure/ladder/rope
	icon_state = "rope"
	base_icon_state = "rope"
	pixel_y = 15
	travel_time = 5 SECONDS
	static_appearance = TRUE

/obj/structure/ladder/rope/upwards
	icon_state = "rope_down"
	pixel_y = -10
