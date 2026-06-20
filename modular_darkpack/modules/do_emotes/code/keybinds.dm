/datum/keybinding/client/communication/do_emote
	hotkey_keys = list("K")
	name = DO_CHANNEL
	full_name = "Do"
	keybind_signal = COMSIG_KB_CLIENT_DO_DOWN

/datum/keybinding/client/communication/do_emote/down(client/user)
	. = ..()
	if(.)
		return
	if(!user.prefs.read_preference(/datum/preference/toggle/tgui_input))
		winset(user, null, "command=[VERB_DO]")
		return TRUE
	winset(user, null, "command=[user.tgui_say_create_open_command(DO_CHANNEL)]")
	winset(user, "tgui_say.browser", "focus=true")
	return TRUE

