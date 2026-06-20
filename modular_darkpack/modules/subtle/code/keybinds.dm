/datum/keybinding/client/communication/subtle
	hotkey_keys = list(UNBOUND_KEY)
	full_name = "Subtle Emote"
	keybind_signal = COMSIG_KB_CLIENT_SUBTLE_DOWN

/datum/keybinding/client/communication/subtle/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.mob.subtle_verb()
	return TRUE

/datum/keybinding/client/communication/subtler
	hotkey_keys = list(UNBOUND_KEY)
	full_name = "Subtler Anti-Ghost"
	keybind_signal = COMSIG_KB_CLIENT_SUBTLER_ANTIGHOST_DOWN

/datum/keybinding/client/communication/subtle/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.mob.subtler_verb()
	return TRUE
