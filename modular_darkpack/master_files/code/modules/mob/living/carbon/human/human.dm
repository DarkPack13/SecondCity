/mob/living/carbon/human/Topic(href, href_list)
	// DARKPACK TODO - reimplement in a sane way.
	if(href_list["masquerade_violation"])
		return

	if(href_list["masquerade_reinforcement"])
		return

	. = ..()
