/mob/living/carbon/human/npc/bacotell
	staying = TRUE

/mob/living/carbon/human/npc/bacotell/Initialize(mapload)
	. = ..()

	if (prob(66))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/shop/bacotell)
