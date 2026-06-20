/datum/keybinding/client/communication/subtle
	hotkey_keys = list(UNBOUND_KEY)
	name = LOOC_CHANNEL
	full_name = "Subtle Emote"
	keybind_signal = COMSIG_KB_CLIENT_LOOC_WALLPIERCE_DOWN

/datum/keybinding/client/communication/subtle/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.mob.subtle_verb()
	return TRUE
