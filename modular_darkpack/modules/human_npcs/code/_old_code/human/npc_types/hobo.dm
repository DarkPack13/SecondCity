/mob/living/carbon/human/npc/poor
	bloodquality = BLOOD_QUALITY_LOW
	old_movement = TRUE

/mob/living/carbon/human/npc/poor/Initialize(mapload)
	. = ..()

	var/datum/socialrole/assign_role = pick(/datum/socialrole/poormale, /datum/socialrole/poorfemale)
	assign_socialrole(assign_role)
