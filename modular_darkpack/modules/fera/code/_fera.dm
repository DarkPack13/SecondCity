// Base type for all transformations for fera, such as corax and garou.
/mob/living/carbon/human/fera
	rotate_on_lying = FALSE
	initial_language_holder = /datum/language_holder/primal

	var/sprite_color = "black"
	var/sprite_scar = 0
	var/sprite_hair = 0
	var/sprite_hair_color = "#000000"
	var/sprite_eye_color = "#FFFFFF"
	var/sprite_apparel = 0

/mob/living/carbon/human/fera/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_JUMPSUIT, "Fera")
	update_appearance()

/mob/living/carbon/human/fera/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	return FALSE
