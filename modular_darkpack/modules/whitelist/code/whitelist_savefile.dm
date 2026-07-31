/datum/preferences/load_preferences()
	. = ..()
	var/list/saved = savefile.get_entry("player_whitelists")
	if(isnull(saved) || !islist(saved) || !length(saved))
		player_whitelists = get_default_player_whitelists().Copy()
	else
		player_whitelists = saved

	for(var/key, bool in get_default_player_whitelists())
		if(!(key in player_whitelists))
			to_chat(parent, span_boldnotice("New whitelist key added to whitelists: [key] [bool ? "TRUE": "FALSE"]."))
			player_whitelists[key] = bool

	if(discipline_trusted && !(WHITELIST_TRUSTED in player_whitelists)) // backwards compatibility
		player_whitelists[WHITELIST_TRUSTED] = TRUE
		if(!isnull(parent))
			to_chat(parent, span_boldnotice("Great news! Your existing trusted status was successfully migrated to the new splat whitelist system."))

	discipline_trusted = (WHITELIST_TRUSTED in player_whitelists)

/datum/preferences/save_preferences()
	if(!isnull(player_whitelists))
		savefile.set_entry("player_whitelists", player_whitelists)
	. = ..()
