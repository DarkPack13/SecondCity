/mob/living/carbon/human/npc/business
	bloodquality = BLOOD_QUALITY_HIGH

/mob/living/carbon/human/npc/business/Initialize(mapload)
	. = ..()

	if (prob(66))
		set_body_weight(SLIM_BODY_WEIGHT)

	var/datum/socialrole/assign_role = pick(/datum/socialrole/richmale, /datum/socialrole/richfemale)
	AssignSocialRole(assign_role)
