/datum/preferences/load_preferences()
	. = ..()
	var/list/saved = savefile.get_entry("player_whitelists")
	if(isnull(saved) || !islist(saved))
		player_whitelists = GLOB.default_player_whitelists.Copy()
		if(discipline_trusted) // backwards compatibility
			player_whitelists += WHITELIST_TRUSTED
	else
		player_whitelists = list()
		for(var/entry in saved)
			if(istext(entry))
				player_whitelists += entry

/datum/preferences/save_preferences()
	savefile.set_entry("player_whitelists", player_whitelists)
	. = ..()
