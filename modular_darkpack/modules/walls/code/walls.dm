#define LOW_WALL_HELPER(wall_type)						\
	/turf/closed/wall/##wall_type/low {					\
		icon = 'modular_darkpack/modules/walls/icons/lowwalls.dmi'; \
		opacity = FALSE;								\
		low = TRUE;										\
		blocks_air = FALSE;								\
		smoothing_groups = SMOOTH_GROUP_CITY_LOW_WALL;	\
		canSmoothWith = SMOOTH_GROUP_CITY_LOW_WALL;		\
		pass_flags_self = PASSTABLE | LETPASSTHROW;		\
	}	\
	/turf/closed/wall/##wall_type/low/window {			\
		window = /obj/structure/window/fulltile;		\
		WHEN_MAP(icon = 'modular_darkpack/modules/walls/icons/lowwalls.dmi'); \
		WHEN_MAP(icon_state = "window_spawner"); 		\
	}	\
	/turf/closed/wall/##wall_type/low/window/reinforced { \
		window = /obj/structure/window/reinforced/fulltile; \
	}


/obj/structure/window/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/window.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/reinforced_window.dmi'

/obj/effect/wall_frill
	name = "wall frill"
	desc = "Hey how are you reading this."
	icon = 'modular_darkpack/modules/walls/icons/wallfrills.dmi'
	base_icon_state = "wall"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/wall_frill/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_WALLS)
/* If we want to have transpanecy for ALL mobs instead of just you.
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(update_alpha),
		COMSIG_ATOM_EXITED = PROC_REF(update_alpha),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/wall_frill/proc/update_alpha()
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
	abstract_type = /turf/closed/wall/vampwall
	opacity = TRUE
	density = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CITY_WALL
	canSmoothWith = SMOOTH_GROUP_CITY_WALL

	baseturfs = /turf/open/floor/plating/concrete

	var/obj/effect/wall_frill/wall_frill
	var/frill_icon = /obj/effect/wall_frill::icon
	var/low = FALSE
	var/window

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
		wall_frill = new(get_step(src, NORTH))
		wall_frill.icon = frill_icon
		wall_frill.icon_state = icon_state
		wall_frill.name = name
		wall_frill.desc = desc

	if(low)
		// Runtimes out the ass.
		//AddComponent(/datum/component/climb_walkable)
		AddElement(/datum/element/climbable)
		// So. This is an obj only thing. Turf are really missing alot of code to make them act more like tables.
		//AddElement(/datum/element/elevation, pixel_shift = 12)

/turf/closed/wall/vampwall/set_smoothed_icon_state(new_junction)
	. = ..()
	if(wall_frill)
		wall_frill.icon_state = icon_state

/turf/closed/wall/vampwall/Destroy()
	. = ..()
	if(wall_frill)
		qdel(wall_frill)

LOW_WALL_HELPER(vampwall)
/turf/closed/wall/vampwall/low/window
	icon_state = "wall-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/rich
	name = "rich-looking wall"
	desc = "A huge chunk of expensive bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/rich/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rich/frill.dmi'

LOW_WALL_HELPER(vampwall/rich)
/turf/closed/wall/vampwall/rich/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/rich/low_wall.dmi'

/turf/closed/wall/vampwall/rich/old
	name = "old rich-looking wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/rich_old/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rich_old/frill.dmi'

LOW_WALL_HELPER(vampwall/rich/old)
/turf/closed/wall/vampwall/rich/old/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/rich_old/low_wall.dmi'

/turf/closed/wall/vampwall/brick_old
	icon = 'icons/obj/smooth_structures/darkpack/wall/brick_old/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/brick_old/frill.dmi'

LOW_WALL_HELPER(vampwall/brick_old)
/turf/closed/wall/vampwall/brick_old/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/brick_old/low_wall.dmi'

/turf/closed/wall/vampwall/junk
	name = "junk brick wall"
	desc = "A huge chunk of dirty bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/junk/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/junk/frill.dmi'

LOW_WALL_HELPER(vampwall/junk)
/turf/closed/wall/vampwall/junk/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/junk/low_wall.dmi'

/turf/closed/wall/vampwall/junk/alt
	icon = 'icons/obj/smooth_structures/darkpack/wall/junk_alt/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/junk_alt/frill.dmi'

LOW_WALL_HELPER(vampwall/junk/alt)
/turf/closed/wall/vampwall/junk/alt/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/junk_alt/low_wall.dmi'

/turf/closed/wall/vampwall/market
	name = "concrete wall"
	desc = "A huge chunk of concrete used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/market/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/market/frill.dmi'

LOW_WALL_HELPER(vampwall/market)
/turf/closed/wall/vampwall/market/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/market/low_wall.dmi'

/turf/closed/wall/vampwall/old
	name = "old brick wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/old/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/old/frill.dmi'

LOW_WALL_HELPER(vampwall/old)
/turf/closed/wall/vampwall/old/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/old/low_wall.dmi'

/turf/closed/wall/vampwall/painted
	name = "painted brick wall"
	desc = "A huge chunk of painted bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/painted/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/painted/frill.dmi'

LOW_WALL_HELPER(vampwall/painted)
/turf/closed/wall/vampwall/painted/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/painted/low_wall.dmi'

/turf/closed/wall/vampwall/brick
	name = "brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/brick/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/brick/frill.dmi'

LOW_WALL_HELPER(vampwall/brick)
/turf/closed/wall/vampwall/brick/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/brick/low_wall.dmi'

/turf/closed/wall/vampwall/redbrick
	name = "red brick wall"
	desc = "A huge chunk of red bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/red_brick/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/red_brick/frill.dmi'

/turf/closed/wall/vampwall/city
	name = "wall"
	desc = "A huge chunk of concrete and bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/city/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/city/frill.dmi'

LOW_WALL_HELPER(vampwall/city)
/turf/closed/wall/vampwall/city/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/city/low_wall.dmi'

/turf/closed/wall/vampwall/metal
	name = "metal wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal/frill.dmi'

/turf/closed/wall/vampwall/metal/reinforced
	name = "reinforced metal wall"
	desc = "A huge chunk of reinforced metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal_reinforced/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal_reinforced/frill.dmi'

/turf/closed/wall/vampwall/metal/alt
	name = "metal wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal_alt/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal_alt/frill.dmi'

/turf/closed/wall/vampwall/metal/glass
	name = "metal wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal_glass/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal_glass/frill.dmi'
	opacity = FALSE

/turf/closed/wall/vampwall/bar
	name = "dark brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/bar/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/bar/frill.dmi'

LOW_WALL_HELPER(vampwall/bar)
/turf/closed/wall/vampwall/bar/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/bar/low_wall.dmi'

/turf/closed/wall/vampwall/wood
	name = "wood wall"
	desc = "A huge chunk of dirty logs used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/wood/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/wood/frill.dmi'

LOW_WALL_HELPER(vampwall/wood)
/turf/closed/wall/vampwall/wood/low
	icon = 'icons/obj/smooth_structures/darkpack/wall/wood/low_wall.dmi'

/turf/closed/wall/vampwall/rust
	name = "rusty wall"
	desc = "A huge chunk of rusty metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/rust/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rust/frill.dmi'

/turf/closed/wall/vampwall/dirtywood
	name = "dirty wood wall"
	desc = "A huge chunk of brown metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/wood_dirty/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/wood_dirty/frill.dmi'


/turf/closed/wall/vampwall/green
	name = "green wall"
	desc = "A huge chunk of green metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/green/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/green/frill.dmi'

/turf/closed/wall/vampwall/rustbad
	name = "rusty wall"
	desc = "A huge chunk of rusty metal used to separate rooms."
	icon = 'icons/obj/smooth_structures/darkpack/wall/rustbad/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rustbad/frill.dmi'

/turf/closed/wall/vampwall/rock
	name = "rock wall"
	desc = "A huge chunk of rocks separating whole territory."
	//icon = 'icons/obj/smooth_structures/darkpack/wall/rock/wall.dmi'
	icon = 'modular_darkpack/modules/walls/icons/rock_wall.dmi' // Unfortuante case where its autocutting is a bit lacking so I manually edit it.
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rock/frill.dmi'

/*
/turf/closed/wall/vampwall/rock/brown
	icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown/frill.dmi'

/turf/closed/wall/vampwall/rock/brown/full
	icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown_full/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown_full/frill.dmi'

/turf/closed/wall/vampwall/mojave/brick
	icon = 'icons/obj/smooth_structures/darkpack/mojave/brick/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/mojave/brick/frill.dmi'
*/

#undef LOW_WALL_HELPER
