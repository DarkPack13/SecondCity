/obj/structure/parapet
	name = "parapet"
	desc = "Basic railing meant to protect idiots like you from falling."
	icon = 'modular_darkpack/modules/decor/icons/parapet.dmi'
	icon_state = "parapet"
	flags_1 = ON_BORDER_1
	obj_flags = CAN_BE_HIT | BLOCKS_CONSTRUCTION_DIR | IGNORE_DENSITY
	density = TRUE
	anchored = TRUE
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
