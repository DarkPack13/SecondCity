/mob/living/carbon/human/npc/garden
	staying = TRUE

/mob/living/carbon/human/npc/garden/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/garden)
