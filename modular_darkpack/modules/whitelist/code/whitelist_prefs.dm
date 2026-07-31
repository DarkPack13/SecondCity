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
	if(whitelist_id == SPLAT_NONE) // as funny as it would be, this should probably be protected
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

/datum/admin_preference_editor/proc/get_whitelist_definitions()
	var/list/defs = list()

	defs[SPLAT_NONE] = list(
		"name" = "Human",
		"description" = "Access to play as a human.",
		"category" = "splat",
		"is_default" = TRUE,
	)
	for(var/splat_id in get_selectable_splats())
		var/splat_type = GLOB.splat_list[splat_id]
		var/datum/splat/splat = GLOB.splat_prototypes[splat_type]

		defs[splat_id] = list(
			"name" = splat.name,
			"description" = "Access to play as a [splat.name].",
			"category" = "splat",
			"is_default" = !splat.check_whitelist_requirement(),
		)

	defs[WHITELIST_TRUSTED] = list(
		"name" = "Trusted",
		"description" = "Bypasses discipline sheet limits, unlocks all trusted-only clans, and allows them to be a lower generation kindred.",
		"category" = "access",
		"is_default" = FALSE,
	)
	defs[WHITELIST_TIMELIMITS] = list(
		"name" = "Bypass Time Requirements",
		"description" = "Bypasses time requierments for jobs.",
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
