//Organovores always like meat & always does not hate meat
/mob/living/carbon/get_liked_foodtypes()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_ORGANOVORE))
		. |= MEAT | GORE | RAW

/mob/living/carbon/get_disliked_foodtypes()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_ORGANOVORE))
		. &= ~(MEAT | GORE | RAW)
