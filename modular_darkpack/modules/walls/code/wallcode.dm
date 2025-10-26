#define LOW_WALL_HELPER(wall_type)						\
	/turf/closed/wall/##wall_type/low {					\
		icon = 'modular_darkpack/modules/walls/icons/lowwalls.dmi'; \
		opacity = FALSE;								\
		low = TRUE;										\
		blocks_air = FALSE;								\
		smoothing_groups = SMOOTH_GROUP_CITY_LOW_WALL;	\
		canSmoothWith = SMOOTH_GROUP_CITY_LOW_WALL;		\
	}	\
	/turf/closed/wall/##wall_type/low/window {			\
		window = /obj/structure/window/fulltile;		\
	}	\
	/turf/closed/wall/##wall_type/low/window/reinforced { \
		window = /obj/structure/window/reinforced/fulltile; \
	}


/obj/structure/window/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/window.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/reinforced_window.dmi'

//Smooth Operator soset biby

/obj/effect/addwall
	name = "Debug"
	desc = "First rule of debug placeholder: Do not talk about debug placeholder."
	icon = 'modular_darkpack/modules/walls/icons/addwalls.dmi'
	base_icon_state = "wall"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	mouse_opacity = 0

/obj/effect/addwall/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_WALLS)
/* If we want to have transpanecy for ALL mobs instead of just you.
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(update_alpha),
		COMSIG_ATOM_EXITED = PROC_REF(update_alpha),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/addwall/proc/update_alpha()
	if(locate(/mob/living) in get_turf(src))
		alpha = 128
	else
		alpha = 255
*/

/turf/closed/wall/vampwall
	name = "old brick wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon = 'modular_darkpack/modules/walls/icons/walls.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	opacity = TRUE
	density = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CITY_WALL
	canSmoothWith = SMOOTH_GROUP_CITY_WALL

	var/obj/effect/addwall/addwall
	var/low = FALSE
	var/window

/turf/closed/wall/vampwall/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(low)
		if(.)
			return
		if(istype(mover) && (mover.pass_flags & PASSTABLE))
			return TRUE
		if(istype(mover.loc, /turf/closed/wall/vampwall)) //Because "low" type walls aren't standardized and are subtypes of different wall types
			var/turf/closed/wall/vampwall/vw = mover.loc
			if(vw.low)
				return TRUE
		//Roughly the same elevation
		if(locate(/obj/structure/table) in get_turf(mover))
			return TRUE

/turf/closed/wall/vampwall/attackby(obj/item/W, mob/user, params)
	return

/turf/closed/wall/vampwall/attack_hand(mob/user)
	return

/turf/closed/wall/vampwall/mouse_drop_receive(atom/dropped, mob/user, params)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if(!living_user.combat_mode)
		//Adds the component only once. We do it here & not in Initialize() because there are tons of walls & we don't want to add to their init times
		LoadComponent(/datum/component/leanable, dropped)
	else
		if(get_dist(user, src) < 2)
			var/turf/user_turf = get_turf(user)
			var/turf/above_turf = GET_TURF_ABOVE(user_turf)
			if(living_user.can_z_move(UP, user_turf, above_turf, ZMOVE_STAIRS_FLAGS, user))
				climb_wall(user, above_turf)
			else
				to_chat(user, span_warning("You can't climb there!"))

/turf/closed/wall/vampwall/proc/climb_wall(mob/living/user, turf/above_turf)
	if(user.body_position != STANDING_UP)
		return
	if(above_turf && istype(above_turf, /turf/open/openspace))
		var/total_dexterity = user.st_get_stat(STAT_DEXTERITY)
		var/total_athletics = user.st_get_stat(STAT_ATHLETICS)
		to_chat(user, span_notice("You start climbing up..."))
		add_fingerprint(user)

		var/result = do_after(user, (11 - total_dexterity - total_athletics) SECONDS, src)
		if(!result || HAS_TRAIT(user, LEANING_TRAIT))
			to_chat(user, span_notice("You were interrupted and failed to climb up."))
			return

		//(Botch, slip and take damage), (Fail, fail to climb), (Success, climb up successfully)
		var/roll = SSroll.storyteller_roll(total_dexterity+total_athletics, 6, user)
		switch(roll)
			if(ROLL_BOTCH)
				user.ZImpactDamage(loc, 1)
				to_chat(user, span_warning("You slip while climbing!"))
				return
			if(ROLL_FAILURE)
				to_chat(user, span_warning("You fail to climb up."))
				return
			else
				user.zMove(UP, above_turf)
				var/turf/forward_turf = get_step(user.loc, user.dir)
				if(forward_turf && !forward_turf.density)
					user.forceMove(forward_turf)
					to_chat(user, span_notice("You climb up successfully."))

/turf/closed/wall/vampwall/ex_act(severity, target)
	return

/turf/closed/wall/vampwall/Initialize(mapload)
	. = ..()
	if(window)
		new window(src)
	else if(!low)
		addwall = new(get_step(src, NORTH))
		addwall.icon_state = icon_state
		addwall.name = name
		addwall.desc = desc

	if(low)
		AddElement(/datum/element/climbable)

/turf/closed/wall/vampwall/set_smoothed_icon_state(new_junction)
	. = ..()
	if(addwall)
		addwall.icon_state = icon_state

/turf/closed/wall/vampwall/Destroy()
	. = ..()
	if(addwall)
		qdel(addwall)

LOW_WALL_HELPER(vampwall)
/turf/closed/wall/vampwall/low/window
	icon_state = "wall-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/rich
	name = "rich-looking wall"
	desc = "A huge chunk of expensive bricks used to separate rooms."
	icon_state = "rich-0"
	base_icon_state = "rich"

LOW_WALL_HELPER(vampwall/rich)
/turf/closed/wall/vampwall/rich/low/window
	icon_state = "rich-window"
/turf/closed/wall/vampwall/rich/low/window/reinforced
	icon_state = "rich-reinforced"

/turf/closed/wall/vampwall/junk
	name = "junk brick wall"
	desc = "A huge chunk of dirty bricks used to separate rooms."
	icon_state = "junk-0"
	base_icon_state = "junk"

LOW_WALL_HELPER(vampwall/junk)
/turf/closed/wall/vampwall/junk/low/window
	icon_state = "junk-window"

/turf/closed/wall/vampwall/junk/alt
	icon_state = "junkalt-0"
	base_icon_state = "junkalt"

LOW_WALL_HELPER(vampwall/junk/alt)
/turf/closed/wall/vampwall/junk/alt/low/window
	icon_state = "junkalt-window"

/turf/closed/wall/vampwall/market
	name = "concrete wall"
	desc = "A huge chunk of concrete used to separate rooms."
	icon_state = "market-0"
	base_icon_state = "market"

LOW_WALL_HELPER(vampwall/market)
/turf/closed/wall/vampwall/market/low/window
	icon_state = "market-window"
/turf/closed/wall/vampwall/market/low/window/reinforced
	icon_state = "market-reinforced"

/turf/closed/wall/vampwall/old
	name = "old brick wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon_state = "old-0"
	base_icon_state = "old"

/turf/closed/wall/vampwall/old/low
	icon = 'modular_darkpack/modules/walls/icons/lowwalls.dmi'
	opacity = FALSE
	low = TRUE
	blocks_air = FALSE
	smoothing_groups = SMOOTH_GROUP_CITY_LOW_WALL
	canSmoothWith = SMOOTH_GROUP_CITY_LOW_WALL
/* Currently missing icon states for window
LOW_WALL_HELPER(vampwall/low)
/turf/closed/wall/vampwall/old/low/window
	icon_state = "old-window"
/turf/closed/wall/vampwall/old/low/window/reinforced
	icon_state = "old-reinforced"
*/

/turf/closed/wall/vampwall/painted
	name = "painted brick wall"
	desc = "A huge chunk of painted bricks used to separate rooms."
	icon_state = "painted-0"
	base_icon_state = "painted"

LOW_WALL_HELPER(vampwall/painted)
/turf/closed/wall/vampwall/painted/low/window
	icon_state = "painted-window"
/turf/closed/wall/vampwall/painted/low/window/reinforced
	icon_state = "painted-reinforced"

/turf/closed/wall/vampwall/rich/old
	name = "old rich-looking wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon_state = "theater-0"
	base_icon_state = "theater"

LOW_WALL_HELPER(vampwall/rich/old)
/turf/closed/wall/vampwall/rich/old/low/window
	icon_state = "theater-window"
/turf/closed/wall/vampwall/rich/old/low/window/reinforced
	icon_state = "theater-reinforced"

/turf/closed/wall/vampwall/brick
	name = "brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon_state = "brick-0"
	base_icon_state = "brick"

LOW_WALL_HELPER(vampwall/brick)
/turf/closed/wall/vampwall/brick/low/window
	icon_state = "brick-window"

/turf/closed/wall/vampwall/rock
	name = "rock wall"
	desc = "A huge chunk of rocks separating whole territory."
	icon_state = "rock-0"
	base_icon_state = "rock"

/turf/closed/wall/vampwall/city
	name = "wall"
	desc = "A huge chunk of concrete and bricks used to separate rooms."
	icon_state = "city-0"
	base_icon_state = "city"

LOW_WALL_HELPER(vampwall/city)
/turf/closed/wall/vampwall/city/low/window
	icon_state = "city-window"

/turf/closed/wall/vampwall/metal
	name = "metal wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon_state = "metal-0"
	base_icon_state = "metal"

/turf/closed/wall/vampwall/metal/reinforced
	name = "reinforced metal wall"
	desc = "A huge chunk of reinforced metal used to separate rooms."
	icon_state = "metalreinforced-0"
	base_icon_state = "metalreinforced"

/turf/closed/wall/vampwall/metal/alt
	name = "metal wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon_state = "metalalt-0"
	base_icon_state = "metalalt"

/turf/closed/wall/vampwall/metal/glass
	name = "metal wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon_state = "metalglass-0"
	base_icon_state = "metalglass"
	opacity = FALSE

/turf/closed/wall/vampwall/bar
	name = "dark brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon_state = "bar-0"
	base_icon_state = "bar"

LOW_WALL_HELPER(vampwall/bar)
/turf/closed/wall/vampwall/bar/low/window
	icon_state = "bar-window"

/turf/closed/wall/vampwall/wood
	name = "wood wall"
	desc = "A huge chunk of dirty logs used to separate rooms."
	icon_state = "wood-0"
	base_icon_state = "wood"

LOW_WALL_HELPER(vampwall/wood)
/turf/closed/wall/vampwall/wood/low/window
	icon_state = "wood-window"

/turf/closed/wall/vampwall/rust
	name = "rusty wall"
	desc = "A huge chunk of rusty metal used to separate rooms."
	icon_state = "rust-0"
	base_icon_state = "rust"

/turf/closed/wall/vampwall/dirtywood
	name = "dirty wood wall"
	desc = "A huge chunk of brown metal used to separate rooms."
	icon_state = "dirtywood-0"
	base_icon_state = "dirtywood"

/turf/closed/wall/vampwall/green
	name = "green wall"
	desc = "A huge chunk of green metal used to separate rooms."
	icon_state = "green-0"
	base_icon_state = "green"

/turf/closed/wall/vampwall/rustbad
	name = "rusty wall"
	desc = "A huge chunk of rusty metal used to separate rooms."
	icon_state = "rustbad-0"
	base_icon_state = "rustbad"

/turf/closed/wall/vampwall/redbrick
	name = "red brick wall"
	desc = "A huge chunk of red bricks used to separate rooms."
	icon_state = "redbrick-0"
	base_icon_state = "redbrick"

// TODO: [Rebase] - Move these to there own file in deticated pr. Want changes visable in this pr.
//TURFS

/turf/open/floor/plating/asphalt
	name = "asphalt"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	add_moonlight()

/turf/open/floor/plating/asphalt/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/asphalt/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/floor/plating/sidewalkalt
	name = "sidewalk"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "sidewalk_alt"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/sidewalkalt/Initialize(mapload)
	. = ..()
	add_moonlight()
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "sidewalk1"
	var/number_of_variations = 3
	base_icon_state = "sidewalk"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/sidewalk/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, number_of_variations)]"
	add_moonlight()
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "parquet"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/parquetry/old
	icon_state = "parquet-old"

/turf/open/floor/plating/parquetry/rich
	icon_state = "parquet-rich"

/turf/open/floor/plating/granite
	name = "granite"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "granite"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/granite/black
	icon_state = "granite-black"

/turf/open/floor/plating/concrete
	name = "concrete"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "concrete1"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/concrete/Initialize(mapload)
	. = ..()
	icon_state = "concrete[rand(1, 4)]"

/turf/open/misc/grass/vamp
	name = "grass"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	add_moonlight()
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "carpet_black"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/misc/dirt/vamp
	name = "dirt"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	add_moonlight()
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "plating"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/vampplating/mono
	icon_state = "plating-mono"

/turf/open/floor/plating/vampplating/stone
	icon_state = "plating-stone"

/turf/open/floor/plating/rough
	name = "rough floor"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "toilet1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/toilet/Initialize(mapload)
	. = ..()
	icon_state = "toilet[rand(1, 9)]"

/turf/open/floor/plating/circled
	name = "fancy plating"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "circle1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/circled/Initialize(mapload)
	. = ..()
	icon_state = "circle[rand(1, 8)]"

/turf/open/floor/plating/church
	name = "fancy plating"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "church1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/church/Initialize(mapload)
	. = ..()
	icon_state = "church[rand(1, 4)]"

/turf/open/floor/plating/saint
	name = "fancy plating"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "saint1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/saint/Initialize(mapload)
	. = ..()
	icon_state = "saint[rand(1, 2)]"

/turf/open/proc/add_moonlight(add_to_starlight = TRUE)
	set_light(l_on = TRUE, l_range = GLOB.starlight_range, l_power = GLOB.starlight_power, l_color = GLOB.starlight_color)

	if(add_to_starlight)
		GLOB.starlight += src
		RegisterSignal(src, COMSIG_TURF_CHANGE, PROC_REF(clear_moonlight))

/turf/open/proc/clear_moonlight()
	SIGNAL_HANDLER
	GLOB.starlight -= src
	UnregisterSignal(src, COMSIG_TURF_CHANGE)

/turf/open/floor/plating/vampwood
	name = "wood"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "bwood"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/plating/vampwood/Initialize(mapload)
	. = ..()
	add_moonlight()
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "bwood"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/misc/beach/vamp
	name = "sand"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	add_moonlight(FALSE)
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.outdoors)
				icon_state = "snow[rand(1, 14)]"

/turf/open/water/beach/vamp
	name = "water"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "ocean"
	baseturfs = /turf/open/water/beach/vamp

/turf/open/water/beach/vamp/Initialize(mapload)
	. = ..()
	add_moonlight(FALSE)

/turf/open/water/beach/vamp/deep
	name = "deep water"
	desc = "Don't forget your life jacket."
	immerse_overlay = "immerse_deep"
	baseturfs = /turf/open/water/beach/vamp/deep
	is_swimming_tile = TRUE

//Make a pr to TG eventually adding acid from shiptest mabye.
/turf/open/water/acid/vamp
	name = "goop"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "acid"
	baseturfs = /turf/open/water/acid/vamp

/turf/open/water/acid/vamp/Initialize(mapload)
	. = ..()
	set_light(1, 0.5, "#1b7c4c")

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

/turf/open/water/vamp_sewer
	name = "sewage"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "black"

/turf/open/floor/plating/bacotell
	name = "plating"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "bacotell"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/gummaguts
	name = "plating"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "gummaguts"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

//Code mostly taken from /obj/crystal_mass
/turf/open/water/bloodwave
	gender = PLURAL
	name = "blood"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
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

#undef LOW_WALL_HELPER
