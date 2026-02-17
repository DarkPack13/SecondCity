/mob/living/carbon/human/Topic(href, href_list)
	// DARKPACK TODO - reimplement in a sane way.
	if(href_list["masquerade_violation"])
		if(!ismundane(usr))
			return
		var/mob/living/carbon/human/reporter = usr
		if(reporter.stat > UNCONSCIOUS)
			return
		if(usr == src)
			return
		var/reason = tgui_input_text(reporter, "Write a description of violation", "Spot a Masquerade violation", null, MAX_MESSAGE_LEN)
		if(reason)
			reason = sanitize(reason)
			message_admins("[ADMIN_LOOKUPFLW(reporter)] spotted [ADMIN_LOOKUPFLW(src)]'s Masquerade violation. Description: [reason]")
			log_game("[ADMIN_LOOKUPFLW(reporter)] spotted [ADMIN_LOOKUPFLW(src)]'s Masquerade violation. Description: [reason]")
			SEND_SIGNAL(reporter, COMSIG_SEEN_MASQUERADE_VIOLATION, src)
			to_chat(src, span_danger("You were found to be violating the masquereade for: [reason]"))

	if(href_list["masquerade_reinforcement"])
		if(!ismundane(usr))
			return
		var/mob/living/carbon/human/reporter = usr
		if(reporter.stat > UNCONSCIOUS)
			return
		if(usr == src)
			return
		message_admins("[ADMIN_LOOKUPFLW(reporter)] repaired [ADMIN_LOOKUPFLW(src)]'s Masquerade violation.")
		log_game("[ADMIN_LOOKUPFLW(reporter)] repaired [ADMIN_LOOKUPFLW(src)]'s Masquerade violation.")
		SEND_SIGNAL(reporter, COMSIG_ALL_MASQUERADE_REINFORCE, src)

	. = ..()
