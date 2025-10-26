/turf/open/floor/plating/asphalt
	name = "asphalt"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "asphalt1"
	footstep = FOOTSTEP_ASPHALT
	barefootstep = FOOTSTEP_ASPHALT

/turf/open/floor/plating/asphalt/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				new /obj/effect/decal/snow_overlay(src)
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW
	if(prob(50))
		icon_state = "asphalt[rand(1, 3)]"
		update_icon()
	if(prob(25))
		new /obj/effect/turf_decal/asphalt(src)

/turf/open/floor/plating/asphalt/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/asphalt/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/floor/plating/sidewalkalt
	name = "sidewalk"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "sidewalk_alt"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/sidewalkalt/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/sidewalk
	name = "sidewalk"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "sidewalk1"
	var/number_of_variations = 3
	base_icon_state = "sidewalk"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/sidewalk/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, number_of_variations)]"
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/sidewalk/poor
	icon_state = "sidewalk_poor1"
	base_icon_state = "sidewalk_poor"

/turf/open/floor/plating/sidewalk/rich
	icon_state = "sidewalk_rich1"
	number_of_variations = 6
	base_icon_state = "sidewalk_rich"

/turf/open/floor/plating/sidewalk/old
	icon_state = "sidewalk_old1"
	number_of_variations = 4
	base_icon_state = "sidewalk_old"

/turf/open/floor/plating/roofwalk
	name = "roof"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "roof"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/roofwalk/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

//Airless version of this because they are used as a z-level 4 roof on a z-level 3 building, and since they aren't meant to be reached...
/turf/open/floor/plating/roofwalk/no_air
	blocks_air = 1

/turf/open/floor/plating/roofwalk/cobblestones
	name = "cobblestones"

//OTHER TURFS

/turf/open/floor/plating/parquetry
	name = "parquetry"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "parquet"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/parquetry/old
	icon_state = "parquet-old"

/turf/open/floor/plating/parquetry/rich
	icon_state = "parquet-rich"

/turf/open/floor/plating/granite
	name = "granite"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "granite"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/granite/black
	icon_state = "granite-black"

/turf/open/floor/plating/concrete
	name = "concrete"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "concrete1"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/concrete/Initialize(mapload)
	. = ..()
	icon_state = "concrete[rand(1, 4)]"

/turf/open/misc/grass/vamp
	name = "grass"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "grass1"
	footstep = FOOTSTEP_TRAVA
	barefootstep = FOOTSTEP_TRAVA
	baseturfs = /turf/open/misc/dirt/vamp
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE


/*
/turf/open/misc/grass/vamp/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/shovel/vamp))
		var/obj/structure/bury_pit/P = locate() in src
		if(P)
			if(!P.burying)
				P.burying = TRUE
				user.visible_message(span_warning("[user] starts to dig [src]"), span_warning("You start to dig [src]."))
				if(do_mob(user, src, 10 SECONDS))
					P.burying = FALSE
					if(P.icon_state == "pit0")
						for(var/mob/living/L in src)
							L.forceMove(P)
						P.icon_state = "pit1"
						user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
					else
						for(var/mob/living/L in P)
							L.forceMove(src)
						P.icon_state = "pit0"
						user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
				else
					P.burying = FALSE
		else
			user.visible_message(span_warning("[user] starts to dig [src]"), span_warning("You start to dig [src]."))
			if(do_mob(user, src, 10 SECONDS))
				if(!locate(/obj/structure/bury_pit) in src)
					user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
					new /obj/structure/bury_pit(src)
*/

/turf/open/misc/grass/vamp/Initialize(mapload)
	. = ..()
	icon_state = "grass[rand(1, 3)]"
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/vampcarpet
	name = "carpet"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "carpet_black"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/misc/dirt/vamp
	name = "dirt"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "dirt"
	footstep = FOOTSTEP_ASPHALT
	barefootstep = FOOTSTEP_ASPHALT
	baseturfs = /turf/open/misc/dirt/vamp
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/*
/turf/open/misc/dirt/vamp/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/shovel/vamp))
		var/obj/structure/bury_pit/P = locate() in src
		if(P)
			if(!P.burying)
				P.burying = TRUE
				user.visible_message(span_warning("[user] starts to dig [src]"), span_warning("You start to dig [src]."))
				if(do_mob(user, src, 10 SECONDS))
					P.burying = FALSE
					if(P.icon_state == "pit0")
						for(var/mob/living/L in src)
							L.forceMove(P)
						P.icon_state = "pit1"
						user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
					else
						for(var/mob/living/L in P)
							L.forceMove(src)
						P.icon_state = "pit0"
						user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
				else
					P.burying = FALSE
		else
			user.visible_message(span_warning("[user] starts to dig [src]"), span_warning("You start to dig [src]."))
			if(do_mob(user, src, 10 SECONDS))
				if(!locate(/obj/structure/bury_pit) in src)
					user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
					new /obj/structure/bury_pit(src)
*/

/turf/open/misc/dirt/vamp/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/misc/dirt/vamp/rails
	name = "rails"
	icon_state = "dirt_rails"

/turf/open/misc/dirt/vamp/rails/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				icon_state = "snow_rails"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/vampplating
	name = "plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "plating"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/vampplating/mono
	icon_state = "plating-mono"

/turf/open/floor/plating/vampplating/stone
	icon_state = "plating-stone"

/turf/open/floor/plating/rough
	name = "rough floor"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "rough"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/rough/cave
	icon_state = "cave1"

/turf/open/floor/plating/rough/cave/Initialize(mapload)
	. = ..()
	icon_state = "cave[rand(1, 7)]"

/turf/open/floor/plating/stone
	name = "rough floor"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "stone"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/stone
	icon_state = "stone1"

/turf/open/floor/plating/stone/Initialize(mapload)
	.=..()
	icon_state = "cave[rand(1, 7)]"

/turf/open/floor/plating/toilet
	name = "plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "toilet1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/toilet/Initialize(mapload)
	. = ..()
	icon_state = "toilet[rand(1, 9)]"

/turf/open/floor/plating/circled
	name = "fancy plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "circle1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/circled/Initialize(mapload)
	. = ..()
	icon_state = "circle[rand(1, 8)]"

/turf/open/floor/plating/church
	name = "fancy plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "church1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/church/Initialize(mapload)
	. = ..()
	icon_state = "church[rand(1, 4)]"

/turf/open/floor/plating/saint
	name = "fancy plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "saint1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/saint/Initialize(mapload)
	. = ..()
	icon_state = "saint[rand(1, 2)]"

/turf/open/floor/plating/vampwood
	name = "wood"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "bwood"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/vampwood/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				//initial_gas_mix = WINTER_DEFAULT_ATMOS
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

// See about porting the apoc sprite for this
/turf/open/floor/plating/woodrough
	name = "wood"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "bwood"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/misc/beach/vamp
	name = "sand"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "sand1"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	baseturfs = /turf/open/misc/beach/vamp
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/*
/turf/open/misc/beach/vamp/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/shovel/vamp))
		var/obj/structure/bury_pit/P = locate() in src
		if(P)
			if(!P.burying)
				P.burying = TRUE
				user.visible_message(span_warning("[user] starts to dig [src]"), span_warning("You start to dig [src]."))
				if(do_mob(user, src, 10 SECONDS))
					P.burying = FALSE
					if(P.icon_state == "pit0")
						for(var/mob/living/L in src)
							L.forceMove(P)
						P.icon_state = "pit1"
						user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
					else
						for(var/mob/living/L in P)
							L.forceMove(src)
						P.icon_state = "pit0"
						user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
				else
					P.burying = FALSE
		else
			user.visible_message(span_warning("[user] starts to dig [src]"), span_warning("You start to dig [src]."))
			if(do_mob(user, src, 10 SECONDS))
				if(!locate(/obj/structure/bury_pit) in src)
					user.visible_message(span_warning("[user] digs a hole in [src]."), span_warning("You dig a hole in [src]."))
					new /obj/structure/bury_pit(src)
*/

/turf/open/misc/beach/vamp/Initialize(mapload)
	. = ..()
	icon_state = "sand[rand(1, 4)]"
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				icon_state = "snow[rand(1, 14)]"

/turf/open/water/beach/vamp
	name = "water"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "ocean"
	baseturfs = /turf/open/water/beach/vamp

/turf/open/water/beach/vamp/deep
	name = "deep water"
	desc = "Don't forget your life jacket."
	immerse_overlay = "immerse_deep"
	baseturfs = /turf/open/water/beach/vamp/deep
	is_swimming_tile = TRUE

//Make a pr to TG eventually adding acid from shiptest mabye.
/turf/open/water/acid/vamp
	name = "goop"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "acid"
	baseturfs = /turf/open/water/acid/vamp
	light_color = "#1b7c4c"
	light_range = 1
	light_power = 0.5

/turf/open/water/acid/vamp/Entered(atom/movable/AM)
	if(acid_burn(AM))
		START_PROCESSING(SSobj, src)

/turf/open/water/acid/vamp/proc/acid_burn(mob/living/L)
	if(isliving(L))
		if(L.movement_type & FLYING)
			return
		L.apply_damage(10, AGGRAVATED)
		L.apply_damage(30, TOX)
		to_chat(L, span_warning("Your flesh burns!"))

/turf/open/water/vamp_sewer
	name = "sewage"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "shit"

/*
/turf/open/water/vamp_sewer/Initialize(mapload)
	. = ..()
	if(prob(50))
		new /obj/effect/realistic_fog(src)
*/

/turf/open/water/vamp_sewer/border
	icon_state = "shit_border"

/turf/open/floor/plating/vampcanal
	name = "plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "canal1"
	footstep = FOOTSTEP_FLOOR

// TODO: [Rebase] - Port https://github.com/ApocryphaXIII/ApocryphaXIII/pull/52
/*
/turf/open/floor/plating/vampcanal/Enter(atom/movable/mover, atom/oldloc)
	. = ..()
	if(istype(mover, /mob/living/carbon/human))
		if(prob(10))
			new /mob/living/basic/mouse/rat/vampire(oldloc)
*/

/turf/open/floor/plating/vampcanal/Initialize(mapload)
	. = ..()
	icon_state = "canal[rand(1, 3)]"

/turf/open/floor/plating/vampcanalplating
	name = "plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "canal_plating1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

// TODO: [Rebase] - Port https://github.com/ApocryphaXIII/ApocryphaXIII/pull/52
/*
/turf/open/floor/plating/vampcanalplating/Enter(atom/movable/mover, atom/oldloc)
	. = ..()
	if(istype(mover, /mob/living/carbon/human))
		if(prob(10))
			new /mob/living/basic/mouse/rat/vampire(oldloc)
*/

/turf/open/floor/plating/vampcanalplating/Initialize(mapload)
	. = ..()
	icon_state = "canal_plating[rand(1, 4)]"

/turf/closed/indestructible/elevatorshaft
	name = "elevator shaft"
	desc = "Floors, floors, floors..."
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "black"

/turf/open/floor/plating/bacotell
	name = "plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "bacotell"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/gummaguts
	name = "plating"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "gummaguts"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

//Code mostly taken from /obj/crystal_mass
/turf/open/water/bloodwave
	gender = PLURAL
	name = "blood"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "blood"
	baseturfs = /turf/open/water/bloodwave
	immerse_overlay = "immerse_deep"
	is_swimming_tile = TRUE
	///All dirs we can expand to
	var/list/available_dirs = list(NORTH,SOUTH,EAST,WEST,DOWN)
	///Cooldown on the expansion process
	COOLDOWN_DECLARE(wave_cooldown)

/turf/open/water/bloodwave/Initialize(mapload, dir_to_remove)
	. = ..()
	set_light(1, 0.5, COLOR_MAROON)
	if(mapload)
		return
	START_PROCESSING(SSsupermatter_cascade, src)
	available_dirs -= dir_to_remove

/turf/open/water/bloodwave/proc/start_flood()
	SSsupermatter_cascade.can_fire = TRUE
	SSsupermatter_cascade.cascade_initiated = TRUE

/turf/open/water/bloodwave/process()

	if(!COOLDOWN_FINISHED(src, wave_cooldown))
		return

	if(!available_dirs || available_dirs.len <= 0)
		return PROCESS_KILL

	COOLDOWN_START(src, wave_cooldown, rand(0, 2 SECONDS))

	var/picked_dir = pick_n_take(available_dirs)
	var/turf/next_turf = get_step_multiz(src, picked_dir)

	if(!next_turf || locate(/turf/open/water/bloodwave) in next_turf)
		return

	for(var/atom/movable/checked_atom as anything in next_turf)
		if(isliving(checked_atom))
			var/mob/living/checked_mob = checked_atom
			checked_mob.death()
		//else if(isitem(checked_atom))
		//	qdel(checked_atom)

	new /turf/open/water/bloodwave(next_turf, get_dir(next_turf, src))
