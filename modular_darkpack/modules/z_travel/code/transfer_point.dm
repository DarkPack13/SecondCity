GLOBAL_LIST_EMPTY(unallocted_transfer_points)

/obj/transfer_point_vamp
	icon = 'modular_darkpack/modules/z_travel/icons/z_travel.dmi'
	icon_state = "matrix_go"
	name = "transfer point"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/obj/transfer_point_vamp/exit
	var/id

/obj/transfer_point_vamp/Initialize(mapload)
	. = ..()
	apply_wibbly_filters(src)
	if(id && !exit)
		GLOB.unallocted_transfer_points += src
		for(var/obj/transfer_point_vamp/other_point in GLOB.unallocted_transfer_points)
			if(other_point.id == id && other_point != src)
				exit = other_point
				GLOB.unallocted_transfer_points -= other_point
				other_point.exit = src
				GLOB.unallocted_transfer_points -= src
				break

/obj/transfer_point_vamp/Destroy(force)
	// Clear the ref to ourselves to prevent hard del
	if(exit)
		exit.exit = null

	GLOB.unallocted_transfer_points -= src
	return ..()

/obj/transfer_point_vamp/vv_edit_var(var_name, var_value)
	. = ..()
	if(var_name == NAMEOF(src, exit))
		if(istype(var_value, /obj/transfer_point_vamp))
			var/obj/transfer_point_vamp/new_exit = var_value
			new_exit.exit = src

/obj/transfer_point_vamp/backrooms
	id = "backrooms"
	alpha = 0

/obj/transfer_point_vamp/backrooms/map
	density = FALSE

/obj/transfer_point_vamp/umbral
	name = "portal"
	icon = 'modular_darkpack/modules/deprecated/icons/48x48.dmi'
	icon_state = "portal"
	plane = ABOVE_LIGHTING_PLANE
	//layer = ABOVE_LIGHTING_LAYER
	pixel_w = -8

/obj/transfer_point_vamp/old_clan_tzimisce
	name = "old clan transfer point"
	icon_state = "matrix_go"
	layer = MID_TURF_LAYER

/obj/transfer_point_vamp/umbral/Initialize(mapload)
	. = ..()
	set_light(2, 1, "#a4a0fb")
	//apply_wibbly_filters(src)

/obj/transfer_point_vamp/umbral/Bumped(atom/movable/AM)
	. = ..()
	playsound(src, 'modular_darkpack/modules/deprecated/sounds/portal_enter.ogg', 75, FALSE)
	if(exit)
		playsound(exit, 'modular_darkpack/modules/deprecated/sounds/portal_enter.ogg', 75, FALSE)

/obj/transfer_point_vamp/Bumped(atom/movable/AM)
	. = ..()
	var/turf/T = get_step(exit, get_dir(AM, src))
	AM.forceMove(T)

/obj/transfer_point_vamp/voivodate
	name = "voivodate transfer point"
	density = 1
	id = "estate_1"

/obj/transfer_point_vamp/voivodate/one
	id = "estate_2"

/obj/transfer_point_vamp/voivodate/two
	id = "estate_3"

/obj/transfer_point_vamp/voivodate/three
	id = "estate_4"
