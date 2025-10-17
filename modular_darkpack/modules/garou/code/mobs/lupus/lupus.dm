/mob/living/carbon/human/fera/lupus
	name = "wolf"
	icon_state = "black"
	icon = 'modular_darkpack/modules/garou/icons/lupus.dmi'
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_HUMAN
	examine_thats = "That's a"

	melee_damage_lower = 10
	melee_damage_upper = 10

	default_num_hands = 1

/mob/living/carbon/human/fera/lupus/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW, 0.5, -11)

/mob/living/carbon/werewolf/lupus/can_hold_items(obj/item/I)
	return ((I.w_class <= WEIGHT_CLASS_SMALL) && ..())
