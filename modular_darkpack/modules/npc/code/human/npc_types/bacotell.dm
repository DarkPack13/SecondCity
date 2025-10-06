/mob/living/carbon/human/npc/bacotell
	staying = TRUE

/mob/living/carbon/human/npc/bacotell/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/bacotell)
