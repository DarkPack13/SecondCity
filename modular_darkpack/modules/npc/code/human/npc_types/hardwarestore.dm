/mob/living/carbon/human/npc/hardwarestore
	staying = TRUE

/mob/living/carbon/human/npc/hardwarestore/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/hardwarestore)
