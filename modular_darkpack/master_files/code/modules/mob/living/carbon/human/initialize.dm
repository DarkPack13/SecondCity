/mob/living/carbon/human/Initialize(mapload)
	. = ..()

	//Initializes Jumping on the player
	AddComponent(/datum/component/jumper)
	AddComponent(/datum/component/violation_observer, violation_aoe)

/mob/living/carbon/human/LateInitialize()
	. = ..()
	update_visible_name()
