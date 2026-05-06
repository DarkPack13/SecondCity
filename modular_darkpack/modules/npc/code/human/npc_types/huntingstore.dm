/mob/living/carbon/human/npc/campingstore
	staying = TRUE

/mob/living/carbon/human/npc/campingstore/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/campingstore)
