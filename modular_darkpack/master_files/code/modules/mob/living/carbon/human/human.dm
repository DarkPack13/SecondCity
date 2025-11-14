/mob/living/carbon/human/Destroy()
	if (clan)
		clan.on_lose(src)

	return ..()

/mob/living/carbon/human/Topic(href, href_list)
	// TODO: [Rebase] - Reimplement in a sane way.
	if(href_list["masquerade_violation"])
		return

	if(href_list["masquerade_reinforcement"])
		return

	. = ..()
