/mob/living/carbon/human/npc/illegal
	staying = TRUE

/mob/living/carbon/human/npc/illegal/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/illegal)
