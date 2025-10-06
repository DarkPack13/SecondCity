/mob/living/carbon/human/npc/bubway
	staying = TRUE

/mob/living/carbon/human/npc/bubway/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/bubway)
