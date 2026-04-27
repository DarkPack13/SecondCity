/datum/preferences/load_preferences()
	. = ..()
	var/list/saved = savefile.get_entry("player_whitelists")
	if(isnull(saved) || !islist(saved))
		player_whitelists = GLOB.default_player_whitelists.Copy()
	else
		player_whitelists = list()
		for(var/entry in saved)
			if(istext(entry))
				player_whitelists += entry

	if(discipline_trusted) // backwards compatibility
		player_whitelists += WHITELIST_TRUSTED
		to_chat(parent, span_notice("LOG: Great news! Your existing trusted status was successfully migrated to the new splat whitelist system."))
		discipline_trusted = null

/datum/preferences/save_preferences()
	. = ..()
	savefile.set_entry("player_whitelists", player_whitelists)
