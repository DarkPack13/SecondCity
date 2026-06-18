/mob/living/basic/bane/religion
	desc = "A strangly familiar looking creature that reminds you of your aunt."
	icon_state = "religion_bane"
	maxHealth = 50
	health = 50
	pass_flags = PASSMOB
	mob_size = MOB_SIZE_SMALL

/mob/living/basic/bane/religion/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)
	AddComponent(/datum/component/swarming)
