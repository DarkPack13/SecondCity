//this is for organovores with can eat trait
/mob/living/carbon/get_liked_foodtypes()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_ORGANOVORE) && !HAS_TRAIT(src, TRAIT_AGEUSIA))
		. |= MEAT | GORE | RAW

/mob/living/carbon/get_disliked_foodtypes()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_ORGANOVORE))
		. &= ~(MEAT | GORE | RAW)
