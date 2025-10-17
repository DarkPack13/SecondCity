/mob/living/carbon/human/fera/crinos
	name = "crinos"
	icon_state = "black"
	icon = 'modular_darkpack/modules/garou/icons/crinos.dmi'
	mob_size = MOB_SIZE_HUGE
	examine_thats = "That's a"

	melee_damage_lower = 10
	melee_damage_upper = 10

	var/sprite_color = "black"
	var/sprite_scar = 0
	var/sprite_hair = 0
	var/sprite_hair_color = "#000000"
	var/sprite_eye_color = "#FFFFFF"
	var/sprite_apparel = 0

/mob/living/carbon/human/fera/crinos/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_HEAVY)

