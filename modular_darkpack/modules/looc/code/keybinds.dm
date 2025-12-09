/datum/keybinding/client/communication/looc
	hotkey_keys = list("L")
	name = LOOC_CHANNEL
	full_name = "Local OOC (LOOC)"
	keybind_signal = COMSIG_KB_CLIENT_LOOC_DOWN

/datum/keybinding/client/communication/looc/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(LOOC_CHANNEL)]")
	winset(user, "tgui_say.browser", "focus=true")
	return TRUE
