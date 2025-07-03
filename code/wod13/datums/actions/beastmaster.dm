/datum/action/beastmaster_stay
	name = "Stay/Follow"
	desc = "Command to stay or follow."
	button_icon_state = "wait"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/cool_down = 0
	var/following = FALSE

/datum/action/beastmaster_stay/Trigger()
	. = ..()

	if (!ishuman(owner))
		return

	if (cool_down + 10 >= world.time)
		return
	cool_down = world.time

	var/mob/living/carbon/human/H = owner
	if (!following)
		following = TRUE
		to_chat(owner, "You call your support.")
		for (var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster)
			B.follow = TRUE
	else
		following = FALSE
		to_chat(owner, "Your support will wait here.")
		for(var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster)
			B.follow = FALSE

/datum/action/beastmaster_deaggro
	name = "Loose Aggression"
	desc = "Command to stop any aggressive moves."
	button_icon_state = "deaggro"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/cool_down = 0

/datum/action/beastmaster_deaggro/Trigger()
	. = ..()

	if (!ishuman(owner))
		return

	if (cool_down+10 >= world.time)
		return
	cool_down = world.time

	var/mob/living/carbon/human/H = owner
	for (var/mob/living/simple_animal/hostile/beastmaster/B in H.beastmaster)
		B.enemies = list()
		B.targa = null
