/obj/item/occult_artifact/werewolf/klaive
	name = "klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This blade has a blue tint, due to the way it was crafted."
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapon_onfloors.dmi')
	icon_state = "klaive"
	force = 2 TTRPG_DAMAGE
	// icon_angle = -45
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor_type = /datum/armor/item_claymore
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/silver = (2 * SHEET_MATERIAL_AMOUNT))

/obj/item/occult_artifact/werewolf/klaive/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	fera_silver_damage(target, 5, 1) // Copyed the other silver weapon. Not super accurate.


/obj/item/occult_artifact/werewolf/klaive/karambit
	name = "curved klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one has a handle made of bone, and is curved."
	icon_state = "klaive_karambit"

/obj/item/occult_artifact/werewolf/klaive/bane
	name = "bane klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one seems rusty, yet still quite sharp"
	icon_state = "klaive_bane"

/obj/item/occult_artifact/werewolf/klaive/grand
	name = "grand klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one is HUGE!."
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/48x32weapons.dmi'
	icon_state = "klaive_grand"
	force = 4 TTRPG_DAMAGE // Should be 5 but needs the extra difficulty as part of https://github.com/DarkPack13/SecondCity/pull/1015 to balance it out.
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = list(/datum/material/silver = (4 * SHEET_MATERIAL_AMOUNT))

