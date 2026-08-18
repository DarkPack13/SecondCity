/mob/living/carbon/human/npc/shop
	staying = TRUE

/mob/living/carbon/human/npc/shop/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop)
