/mob/living/carbon/human/npc/gummaguts
	staying = TRUE

/mob/living/carbon/human/npc/gummaguts/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/gummaguts)
