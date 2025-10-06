/mob/living/carbon/human/npc/incel
	staying = TRUE

/mob/living/carbon/human/npc/incel/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/usualmale)
