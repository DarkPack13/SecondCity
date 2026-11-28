/obj/structure/parapet
	name = "parapet"
	desc = "Basic railing meant to protect idiots like you from falling."
	icon = 'modular_darkpack/modules/decor/icons/parapet.dmi'
	icon_state = "parapet"
	flags_1 = ON_BORDER_1
	obj_flags = CAN_BE_HIT | BLOCKS_CONSTRUCTION_DIR | IGNORE_DENSITY
	density = TRUE
	anchored = TRUE
	var/climbable = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	pass_flags_self = LETPASSTHROW|PASSSTRUCTURE
	layer = ABOVE_TREE_LAYER
	plane = ABOVE_GAME_PLANE
	/// armor is a little bit less than a grille. max_integrity about half that of a grille.
	armor_type = /datum/armor/structure_railing
	max_integrity = 50 // little stronger than railing

/obj/structure/parapet/low
	name = "parapet"
	icon_state = "parapet_low"

/obj/structure/parapet/unbreakable
	resistance_flags = INDESTRUCTIBLE

/obj/structure/parapet/low/unbreakable
	resistance_flags = INDESTRUCTIBLE

/obj/structure/parapet/corner
	icon_state = "parapet_corner"
	density = FALSE
	climbable = FALSE

/obj/structure/parapet/corner/low/unbreakable
	resistance_flags = INDESTRUCTIBLE

/obj/structure/parapet/corner
	icon_state = "parapet_corner"
	density = FALSE
	climbable = FALSE

/obj/structure/parapet/corner/low
	icon_state = "parapet_low_corner"
	density = FALSE
	climbable = FALSE

/obj/structure/parapet/corner/low/unbreakable
	resistance_flags = INDESTRUCTIBLE

/obj/structure/parapet/corner/low/unbreakable
	resistance_flags = INDESTRUCTIBLE

// -- behavior stuff --

/obj/structure/parapet/Initialize(mapload)
	. = ..()
	if(climbable)
		AddElement(/datum/element/climbable)

	if(density && flags_1 & ON_BORDER_1) // blocks normal movement from and to the direction it's facing.
		var/static/list/loc_connections = list(
			COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		)
		AddElement(/datum/element/connect_loc, loc_connections)

	AddElement(/datum/element/simple_rotation, ROTATION_NEEDS_ROOM)

/obj/structure/parapet/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	add_fingerprint(user)
	return ..()

/obj/structure/parapet/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || (mover.movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
	return TRUE

/obj/structure/parapet/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	if(!(to_dir & dir))
		return TRUE
	return ..()

/obj/structure/parapet/proc/on_exit(datum/source, atom/movable/leaving, direction)
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

/obj/structure/parapet/proc/check_anchored(checked_anchored)
	if(anchored == checked_anchored)
		return TRUE
