/mob/living/carbon/human/npc/garden
	staying = TRUE
	is_talking = TRUE

/mob/living/carbon/human/npc/garden/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/garden)
