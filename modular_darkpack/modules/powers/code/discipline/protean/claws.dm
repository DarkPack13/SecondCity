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
	armour_penetration = 40
	block_chance = 20
	item_flags = DROPDEL
	masquerade_violating = TRUE
	obj_flags = NONE

/obj/item/gangrel_claws/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

/obj/item/gangrel_claws/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	// Based on V20
	if(isliving(user))
		var/mob/living/living_user = user
		force = (living_user.st_get_stat(STAT_STRENGTH) + 1) TTRPG_DAMAGE
