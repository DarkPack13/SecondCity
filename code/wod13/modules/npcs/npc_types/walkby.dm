/mob/living/carbon/human/npc/walkby

/mob/living/carbon/human/npc/walkby/Initialize(mapload)
	. = ..()

	if (prob(50))
		set_body_weight(pick(SLIM_BODY_WEIGHT, FAT_BODY_WEIGHT))

	var/datum/socialrole/assign_role = pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale)
	AssignSocialRole(assign_role)
