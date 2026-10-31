/mob/living/carbon/human/npc/incel
	staying = TRUE
	taint_wyrm = 3

/mob/living/carbon/human/npc/incel/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/usualmale)
