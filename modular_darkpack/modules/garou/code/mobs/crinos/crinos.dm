/mob/living/carbon/human/fera/crinos
	name = "crinos"
	icon_state = "black"
	icon = 'modular_darkpack/modules/garou/icons/crinos.dmi'
	mob_size = MOB_SIZE_HUGE
	examine_thats = "That's a"
	SET_BASE_PIXEL(-8, 0)

	melee_damage_lower = 10
	melee_damage_upper = 10

	race = /datum/species/human/fera/garou
	transformation_size_width = 1.5
	transformation_size_height = 1.5

/mob/living/carbon/human/fera/crinos/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_HEAVY)

