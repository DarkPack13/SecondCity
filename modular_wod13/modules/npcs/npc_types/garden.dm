/mob/living/carbon/human/npc/garden
	staying = TRUE
	is_talking = TRUE

/mob/living/carbon/human/npc/garden/Initialize(mapload)
	. = ..()

	if (prob(66))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/shop/garden)
