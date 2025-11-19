/mob/living/basic/deer
	name = "deer"
	desc = "A gentle, peaceful forest animal."
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	icon = 'modular_darkpack/modules/npc/icons/deer.dmi'
	gender = PLURAL

/mob/living/basic/deer/Initialize(mapload)
	. = ..()
	if(gender == MALE)
		name = "buck"
		icon_state = "deer_antlers"
		icon_living = "deer_antlers"
		icon_dead = "deer_antlers_dead"
	else
		name = "doe"
		icon_state = "deer"
		icon_living = "deer"
		icon_dead = "deer_dead"

/*
/mob/living/basic/deer
	name = "deer"
	desc = "A gentle, peaceful forest animal."
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	icon = 'modular_darkpack/modules/npc/icons/deer.dmi'
	gender = PLURAL
	var/antlers = FALSE
	var/in_headlights = FALSE

/mob/living/basic/deer/Initialize(mapload)
	. = ..()
	if(gender == MALE)
		name = "buck"
		antlers = TRUE
	else
		name = "doe"

	update_overlays()

/mob/living/basic/deer/update_overlays()
	. = ..()

	if(antlers)
		. += mutable_appearance(icon, "antlers[(stat == DEAD) ? "_dead" : ""]_overlay")

	if(in_headlights && (stat != DEAD))
		. += mutable_appearance(icon, "headlights_overlay")
*/
