/mob/living/carbon/human/Topic(href, href_list)
	// DARKPACK TODO - reimplement in a sane way.
	if(href_list["masquerade_violation"])
		if(!ishumanbasic(usr))
			return
		var/mob/living/carbon/human/H = usr
		if(H.stat > UNCONSCIOUS)
			return
		if(usr == src)
			return
		var/reason = tgui_input_text(H, "Write a description of violation", "Spot a Masquerade violation", null, MAX_MESSAGE_LEN)
		if(reason)
			if (H.voted_for.Find(dna.real_name)) //Rudimentary check to avoid queueing a whole bunch of reason texts and then nuking their masquerade to 0.
				to_chat(H, span_warning("You have already noted their masquerade breach! Wait some time until you do that again."))
				return
			reason = sanitize(reason)
			message_admins("[ADMIN_LOOKUPFLW(H)] spotted [ADMIN_LOOKUPFLW(src)]'s Masquerade violation. Description: [reason]")
			H.voted_for |= dna.real_name
			last_masquerade_violation = 0
			SEND_SIGNAL(H, COMSIG_SEEN_MASQUERADE_VIOLATION, src)
			to_chat(src, span_danger("You were found to be violating the masquereade for: [reason]"))

	if(href_list["masquerade_reinforcement"])
		if(!ishumanbasic(usr))
			return
		var/mob/living/carbon/human/H = usr
		if(H.stat > UNCONSCIOUS)
			return
		if(usr == src)
			return
		if(H.voted_for.Find(real_name))
			message_admins("[ADMIN_LOOKUPFLW(H)] repaired [ADMIN_LOOKUPFLW(src)]'s Masquerade violation.")
			SEND_SIGNAL(H, COMSIG_MASQUERADE_REINFORCE, src)
			H.voted_for -= real_name
		else
			to_chat(H, span_warning("You didin't report a masquerade breach on this person!"))

	. = ..()
