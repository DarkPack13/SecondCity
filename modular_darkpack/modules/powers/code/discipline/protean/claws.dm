/obj/item/gangrel_claws
	name = "claws"
	desc = "Don't cut yourself accidentally."
	icon_state = "gangrel"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	hitsound = 'sound/items/weapons/slash.ogg'
	force = 1 TTRPG_DAMAGE
	damtype = AGGRAVATED // Based on V20
	sharpness = SHARP_POINTY
	item_flags = DROPDEL
	masquerade_violating = TRUE
	obj_flags = NONE
	st_attack_attribute = STAT_BRAWL

/obj/item/gangrel_claws/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_NATURAL, INNATE_TRAIT)

