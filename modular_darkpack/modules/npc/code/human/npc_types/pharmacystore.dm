/mob/living/carbon/human/npc/pharmacystore
	staying = TRUE

/mob/living/carbon/human/npc/pharmacystore/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/pharmacystore)
