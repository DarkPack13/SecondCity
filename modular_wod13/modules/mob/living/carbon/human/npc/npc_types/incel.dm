/mob/living/carbon/human/npc/incel
	staying = TRUE

/mob/living/carbon/human/npc/incel/Initialize(mapload)
	. = ..()

	if (prob(50))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/usualmale)
