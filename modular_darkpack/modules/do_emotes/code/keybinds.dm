/datum/keybinding/client/communication/do_emote
	hotkey_keys = list("K")
	name = DO_CHANNEL
	full_name = "Do"
	keybind_signal = COMSIG_KB_CLIENT_DO_DOWN

/datum/keybinding/client/communication/do_emote/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.emote("do_emote")
	return TRUE
