/mob/living/carbon/human/npc/gunstore
	staying = TRUE

/mob/living/carbon/human/npc/gunstore/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/gunstore)
