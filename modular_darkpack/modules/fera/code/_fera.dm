// Base type for all transformations for fera, such as corax and garou.
/mob/living/carbon/human/fera
	rotate_on_lying = FALSE
	initial_language_holder = /datum/language_holder/primal
	var/transformation_sound = 'modular_darkpack/modules/garou/sound/transform.ogg'

/mob/living/carbon/human/fera/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_JUMPSUIT, "Fera")
	update_appearance()

/mob/living/carbon/human/fera/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	return FALSE
