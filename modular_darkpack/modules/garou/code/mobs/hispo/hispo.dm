/mob/living/carbon/human/fera/hispo
	name = "hispo"
	icon_state = "black"
	icon = 'modular_darkpack/modules/garou/icons/hispo.dmi'
	mob_size = MOB_SIZE_LARGE
	examine_thats = "That's a"

	melee_damage_lower = 10
	melee_damage_upper = 10

/mob/living/carbon/human/fera/hispo/Initialize(mapload)
	. = ..()
	add_offsets("Hispo", 0, -32, -32, 0, FALSE)

