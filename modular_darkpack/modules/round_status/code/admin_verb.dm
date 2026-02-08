ADMIN_VERB(toggle_canon, R_ADMIN, "Toggle Canon", "Toggle the canon of the round.", ADMIN_CATEGORY_EVENTS)
	GLOB.canon_event = !GLOB.canon_event
	SEND_SOUND(world, sound('modular_darkpack/modules/round_status/sounds/canon.ogg', FALSE, FALSE, 25))
	if(GLOB.canon_event)
		to_chat(world, "<b>THE ROUND IS NOW CANON. DATA WILL SAVE.</b>")
	else
		to_chat(world, "<b>THE ROUND IS NO LONGER CANON. DATA WILL NO LONGER SAVE. ROLEPLAY AND ESCALATION IS STILL EXPECTED.</b>")
	message_admins("[key_name_admin(usr)] toggled the round's canonicity. The round is [GLOB.canon_event ? "now canon." : "no longer canon."]")
	log_admin("[key_name(usr)] toggled the round's canonicity. The round is [GLOB.canon_event ? "now canon." : "no longer canon."]")

	BLACKBOX_LOG_ADMIN_VERB("Toggle Canon")
