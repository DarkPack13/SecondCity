/mob/living/carbon/human/npc/gummaguts
	staying = TRUE
	taint_wyrm = 1

/mob/living/carbon/human/npc/gummaguts/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/gummaguts)
