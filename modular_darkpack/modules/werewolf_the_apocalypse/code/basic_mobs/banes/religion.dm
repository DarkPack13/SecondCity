/mob/living/basic/bane/religion
	desc = "A strangly familier looking creature that reminds you of your aunt."
	icon_state = "religion_bane"
	maxHealth = 50
	health = 50

/mob/living/basic/bane/religion/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)
