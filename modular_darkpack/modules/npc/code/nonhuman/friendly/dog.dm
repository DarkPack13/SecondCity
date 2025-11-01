/mob/living/basic/pet/dog/darkpack
	name = "\improper dog"
	real_name = "dog"
	icon_state = "dog1"
	desc = "That's an ouppy."
	base_icon_state = "dog"
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	var/random_dog_color = TRUE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT

/mob/living/basic/pet/dog/darkpack/Initialize(mapload)
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	if(random_dog_color)
		var/id = rand(1, 6)
		icon_state = "[base_icon_state][id]"
		icon_living = "[base_icon_state][id]"
		icon_dead = "[base_icon_state][id]_dead"

/mob/living/basic/pet/dog/darkpack/update_icon_state()
	. = ..()
	if(stat != DEAD)
		if(resting)
			icon_state = "[icon_living]_rest"
		else
			icon_state = "[icon_living]"
