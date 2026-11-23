/mob/living/carbon/human/npc/illegal
	staying = TRUE

/mob/living/carbon/human/npc/illegal/Initialize(mapload)
	. = ..()

	assign_socialrole(/datum/socialrole/shop/illegal)
