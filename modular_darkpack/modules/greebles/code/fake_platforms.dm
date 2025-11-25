#define FAKE_PLATFORM_HELPER(platform_type, platform_icon, double_icon)	\
	/obj/fake_platform/##platform_type {	\
		icon_state = ##platform_icon; \
	}	\
	/obj/fake_platform/##platform_type/double{	\
		icon_state = ##double_icon;	\
	}	\
	/obj/fake_platform/##platform_type/easyclimb { \
		density = FALSE; \
		climbable = FALSE; \
	}	\
	/obj/fake_platform/##platform_type/double/easyclimb { \
		density = FALSE; \
		climbable = FALSE; \
	}	\
	/obj/fake_platform/##platform_type/noclimb { \
		climbable = FALSE; \
	}	\
	/obj/fake_platform/##platform_type/double/noclimb { \
		climbable = FALSE; \
	}

/obj/fake_platform
	name = "platform"
	desc = "Don't stub your toe."
	icon = 'modular_darkpack/modules/greebles/icons/fake_platforms.dmi'
	abstract_type = /obj/fake_platform
	flags_1 = ON_BORDER_1
	obj_flags = CAN_BE_HIT | BLOCKS_CONSTRUCTION_DIR | IGNORE_DENSITY
	density = TRUE
	anchored = TRUE
	dir = NORTH
	pass_flags_self = LETPASSTHROW|PASSSTRUCTURE
	layer = BELOW_CATWALK_LAYER
	plane = WALL_PLANE

	var/climbable = TRUE

/obj/fake_platform/Initialize(mapload)
	. = ..()
	if(climbable)
		AddElement(/datum/element/climbable)

	if(density && flags_1 & ON_BORDER_1) // blocks normal movement from and to the direction it's facing.
		var/static/list/loc_connections = list(
			COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		)
		AddElement(/datum/element/connect_loc, loc_connections)

/obj/fake_platform/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || (mover.movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
	return TRUE

/obj/fake_platform/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(!(to_dir & dir))
		return TRUE
	return ..()

/obj/fake_platform/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving == src)
		return // Let's not block ourselves.

	if(!(direction & dir))
		return

	if (!density)
		return

	if (leaving.throwing)
		return

	if (leaving.movement_type & (PHASING|MOVETYPES_NOT_TOUCHING_GROUND))
		return

	if (leaving.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return

	leaving.Bump(src)
	return COMPONENT_ATOM_BLOCK_EXIT

FAKE_PLATFORM_HELPER(wallpaper, "wallpaper", "wallpaper_double")
FAKE_PLATFORM_HELPER(grey, "grey", "grey_double")
FAKE_PLATFORM_HELPER(grey, "grey", "grey_double")
FAKE_PLATFORM_HELPER(light, "light", "light_double")
FAKE_PLATFORM_HELPER(asylum, "asylum", "asylum_double")
FAKE_PLATFORM_HELPER(asylum_clean, "asylum_clean", "asylum_clean_double")
FAKE_PLATFORM_HELPER(club, "club", "club_double")
FAKE_PLATFORM_HELPER(cheap, "cheap", "cheap_double")
FAKE_PLATFORM_HELPER(green, "green", "green_double")
FAKE_PLATFORM_HELPER(stripe, "stripe", "stripe_double")
FAKE_PLATFORM_HELPER(rich, "rich", "rich_double")
FAKE_PLATFORM_HELPER(rich_alt, "rich_alt", "rich_alt_double")
FAKE_PLATFORM_HELPER(stone, "stone", "stone_double")
FAKE_PLATFORM_HELPER(stone_dual, "stone_dual", "stone_dual_double")
FAKE_PLATFORM_HELPER(dgreen, "dgreen", "dgreen_double")
FAKE_PLATFORM_HELPER(dred, "dred", "dred_double")
FAKE_PLATFORM_HELPER(gold, "gold", "gold_double")
FAKE_PLATFORM_HELPER(gold_alt, "gold_alt", "gold_alt_double")
FAKE_PLATFORM_HELPER(gold_simple, "gold_simple", "gold_simple_double")
FAKE_PLATFORM_HELPER(necro, "necro", "necro_double")
FAKE_PLATFORM_HELPER(padded, "padded", "padded_double")
FAKE_PLATFORM_HELPER(lightpadded, "lightpadded", "lightpadded_double")

#undef FAKE_PLATFORM_HELPER
