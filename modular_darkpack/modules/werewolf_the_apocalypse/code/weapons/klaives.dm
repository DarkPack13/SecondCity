/obj/item/claymore/klaive
	name = "klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This blade has a blue tint, due to the way it was crafted."
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapon_onfloors.dmi')
	icon_state = "klaive"
	inhand_icon_state = null // Please default to the icon_state.
	force = 2 TTRPG_DAMAGE
	block_chance = 0 // I dont really think it needs 50 block tbh.
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/silver = (2 * SHEET_MATERIAL_AMOUNT))

/obj/item/claymore/klaive/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	fera_silver_damage(target, 5, 1) // Copyed the other silver weapon. Not super accurate.


/obj/item/claymore/klaive/karambit
	name = "curved klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one has a handle made of bone, and is curved."
	icon_state = "klaive_karambit"

/obj/item/claymore/klaive/bane
	name = "bane klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one seems rusty, yet still quite sharp"
	icon_state = "klaive_bane"

/obj/item/claymore/klaive/grand
	name = "grand klaive"
	desc = "A ritual weapon crafted by the Garou out of silver. This one is HUGE!."
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/48x32weapons.dmi'
	icon_state = "klaive_grand"
	force = 4 TTRPG_DAMAGE // Should be 5 but needs the extra difficulty as part of https://github.com/DarkPack13/SecondCity/pull/1015 to balance it out.
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = list(/datum/material/silver = (4 * SHEET_MATERIAL_AMOUNT))

