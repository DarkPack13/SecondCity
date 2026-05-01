/datum/keybinding/client/communication/do_emote
	hotkey_keys = list("K")
	name = DO_CHANNEL
	full_name = "Do"
	keybind_signal = COMSIG_KB_CLIENT_DO_DOWN

/datum/keybinding/client/communication/do_emote/down(client/user)
	. = ..()
	if(.)
		return
	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(user.mob, TYPE_PROC_REF(/mob, emote), "do_emote"))
	return TRUE
