/mob/living/carbon/human/npc/business
	bloodquality = BLOOD_QUALITY_HIGH

/mob/living/carbon/human/npc/business/Initialize(mapload)
	. = ..()

	var/datum/socialrole/assign_role = pick(/datum/socialrole/richmale, /datum/socialrole/richfemale)
	AssignSocialRole(assign_role)
