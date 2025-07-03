/mob/living/carbon/human/npc/stripper
	staying = TRUE

/mob/living/carbon/human/npc/stripper/Initialize(mapload)
	. = ..()

	set_body_weight(SLIM_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/stripfemale)

	underwear = "Nude"
	undershirt = "Nude"
	socks = "Nude"

	update_body()

/mob/living/carbon/human/npc/stripper/Life()
	. = ..()

	if (stat >= UNCONSCIOUS)
		return
	if (!prob(20))
		return

	INVOKE_ASYNC(src, PROC_REF(pole_dance))

/mob/living/carbon/human/npc/stripper/proc/pole_dance()
	// TODO: [Lucia] reimplement decor
	/*
	for (var/obj/structure/pole/pole in range(1, src))
		drop_all_held_items()
		ClickOn(pole)
	*/
