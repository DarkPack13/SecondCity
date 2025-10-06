/mob/living/carbon/human/npc/walkby

/mob/living/carbon/human/npc/walkby/Initialize(mapload)
	. = ..()

	var/datum/socialrole/assign_role = pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale)
	AssignSocialRole(assign_role)
