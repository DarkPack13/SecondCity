GLOBAL_LIST_INIT(trusted_only_clans, list(
	VAMPIRE_CLAN_BAALI,
	VAMPIRE_CLAN_HEALER_SALUBRI,
	VAMPIRE_CLAN_WARRIOR_SALUBRI,
	VAMPIRE_CLAN_TRUE_BRUJAH,
	VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY,
	VAMPIRE_CLAN_SAMEDI,
))

// remember kids, you should always obtain enthusiastic informed values before proceeding
/datum/preference/choiced/subsplat/vampire_clan/create_informed_default_value(datum/preferences/preferences)
	if(preferences && !preferences.discipline_trusted)
		var/list/safe_choices = list()
		for(var/choice in get_choices())
			var/datum/subsplat/vampire_clan/clan = get_vampire_clan(choice)
			if(!clan || !(clan.id in GLOB.trusted_only_clans))
				safe_choices += choice
		if(length(safe_choices))
			return pick(safe_choices)
	return ..()

/datum/preference/choiced/subsplat/vampire_clan/is_valid(value, datum/preferences/preferences)
	if(preferences && !preferences.discipline_trusted)
		var/datum/subsplat/vampire_clan/clan = get_vampire_clan(value)
		if(clan?.id in GLOB.trusted_only_clans)
			to_chat(preferences.parent, span_warning("The [clan.name] clan requires a special whitelisting process. Feel free to apply for it on Discord!"))
			return FALSE
	return ..()

// helper procs to make absolutely sure unwhitelisted people cannot join with whitelisted splats
// useful in-case a regime member removes a trusted player from the whitelist
// so they cant continue to play on the trusted character with that clan selected
/proc/get_restricted_clan(mob/dead/new_player/new_player)
	var/client/C = new_player.client
	if(!C?.prefs)
		return null
	if(C.prefs.discipline_trusted)
		return null
	var/selected = C.prefs.read_preference(/datum/preference/choiced/subsplat/vampire_clan)
	var/datum/subsplat/vampire_clan/clan = get_vampire_clan(selected)
	if(clan?.id in GLOB.trusted_only_clans)
		return clan
	return null

/atom/movable/screen/lobby/button/ready/Click(location, control, params)
	var/mob/dead/new_player/new_player = hud.mymob
	if(new_player.ready == PLAYER_NOT_READY)
		var/datum/subsplat/vampire_clan/clan = get_restricted_clan(new_player)
		if(clan)
			to_chat(new_player, span_warning("[clan.name] requires a special whitelisting process. Feel free to apply for it on Discord!"))
			return
	return ..()

/atom/movable/screen/lobby/button/join/Click(location, control, params)
	var/mob/dead/new_player/new_player = hud.mymob
	var/datum/subsplat/vampire_clan/clan = get_restricted_clan(new_player)
	if(clan)
		to_chat(new_player, span_warning("[clan.name] requires a special whitelisting process. Feel free to apply for it on Discord!"))
		return
	return ..()
