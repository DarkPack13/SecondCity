/mob/living/basic/deer
	name = "deer"
	desc = "A gentle, peaceful forest animal."
	icon = 'modular_vcg/modules/npc/icons/32x32small.dmi'
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"

/mob/living/basic/deer/Initialize(mapload)
	. = ..()
	if(gender == MALE)
		name = "buck"
		if(prob(90))
			antlers = TRUE
	else
		name = "doe"

	update_appearance(UPDATE_OVERLAYS)

/mob/living/basic/deer/update_overlays()
	. = ..()

	if(antlers)
		. += "antlers[(stat == DEAD) ? "_dead" : ""]_overlay"

	if(in_headlights && (stat != DEAD))
		. += "headlights_overlay"
