/datum/preferences
	var/list/player_whitelists = null

/datum/preferences/proc/get_player_whitelists()
	if(isnull(player_whitelists))
		player_whitelists = GLOB.default_player_whitelists.Copy()
	return player_whitelists

/datum/preferences/proc/has_whitelist(whitelist_id)
	return whitelist_id in get_player_whitelists()

/datum/preferences/proc/grant_whitelist(whitelist_id)
	var/list/wl = get_player_whitelists()
	if(whitelist_id in wl)
		return
	wl += whitelist_id
	if(whitelist_id == WHITELIST_TRUSTED)
		discipline_trusted = TRUE

/datum/preferences/proc/revoke_whitelist(whitelist_id)
	if(whitelist_id == WHITELIST_HUMAN) // as funny as it would be, this should probably be protected
		return
	var/list/wl = get_player_whitelists()
	wl -= whitelist_id
	if(whitelist_id == WHITELIST_TRUSTED)
		discipline_trusted = FALSE

/datum/preference_middleware/disciplines/get_ui_data(mob/user)
	var/list/data = ..()
	var/datum/preferences/prefs = user?.client?.prefs
	var/list/player_wl = prefs ? prefs.get_player_whitelists() : null
	data["player_whitelists"] = player_wl ? player_wl.Copy() : list()
	return data

/datum/admin_discipline_editor/proc/get_whitelist_definitions()
	var/list/defs = list()

	defs[WHITELIST_VAMPIRE] = list(
		"name" = "Vampire",
		"description" = "Access to play as a vampire.",
		"category" = "splat",
		"is_default" = TRUE,
	)
	defs[WHITELIST_GHOUL] = list(
		"name" = "Ghoul",
		"description" = "Access to play as a ghoul.",
		"category" = "splat",
		"is_default" = TRUE,
	)
	defs[WHITELIST_KINFOLK] = list(
		"name" = "Kinfolk",
		"description" = "Access to play as kinfolk.",
		"category" = "splat",
		"is_default" = FALSE,
	)
	defs[WHITELIST_GAROU] = list(
		"name" = "Garou",
		"description" = "Access to play as garou.",
		"category" = "splat",
		"is_default" = FALSE,
	)
	defs[WHITELIST_TRUSTED] = list(
		"name" = "Trusted",
		"description" = "Bypasses discipline sheet limits, unlocks all trusted-only clans, and allows them to be a lower generation kindred.",
		"category" = "access",
		"is_default" = FALSE,
	)

	for(var/clan_name in GLOB.vampire_clan_list)
		var/datum/subsplat/vampire_clan/clan = get_vampire_clan(clan_name)
		if(!clan || !(clan.id in GLOB.trusted_only_clans))
			continue
		defs[clan.id] = list(
			"name" = clan.name,
			"description" = "Access to play [clan.name] without requiring trusted whitelist",
			"category" = "clan",
			"is_default" = FALSE,
		)

	return defs
