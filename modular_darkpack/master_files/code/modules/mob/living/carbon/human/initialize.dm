/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	update_blood_hud()

	//Initializes Jumping on the player
	AddComponent(/datum/component/jumper)
	AddComponent(/datum/component/violation_observer, violation_aoe)
