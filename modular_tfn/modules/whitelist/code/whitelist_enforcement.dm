/mob/dead/new_player/proc/get_restricted_splat_name()
	var/client/C = client
	if(!C?.prefs)
		return null
	var/splat_path = C.prefs.read_preference(/datum/preference/choiced/splats)
	if(!ispath(splat_path, /datum/splat))
		if(!C.prefs.has_whitelist(WHITELIST_HUMAN))
			return "Human"
		return null
	var/datum/splat/splat = GLOB.splat_prototypes[splat_path]
	if(!splat)
		return null
	var/required = GLOB.splat_whitelists[splat.id]
	if(!isnull(required) && !C.prefs.has_whitelist(required))
		return splat.name
	return null

/atom/movable/screen/lobby/button/ready/Click(location, control, params)
	var/mob/dead/new_player/new_player = hud.mymob
	if(new_player.ready == PLAYER_NOT_READY)
		var/splat_name = new_player.get_restricted_splat_name()
		if(splat_name)
			to_chat(new_player, span_warning("[splat_name] requires a special whitelisting process. Feel free to apply for it on Discord!"))
			return
	return ..()

/atom/movable/screen/lobby/button/join/Click(location, control, params)
	var/mob/dead/new_player/new_player = hud.mymob
	var/splat_name = new_player.get_restricted_splat_name()
	if(splat_name)
		to_chat(new_player, span_warning("[splat_name] requires a special whitelisting process. Feel free to apply for it on Discord!"))
		return
	return ..()

/datum/preference/choiced/splats/is_valid(value, datum/preferences/preferences)
	if(preferences)
		var/splat_id = SPLAT_NONE
		if(ispath(value, /datum/splat))
			var/datum/splat/splat = GLOB.splat_prototypes[value]
			splat_id = splat?.id || SPLAT_NONE
		var/required
		if(splat_id == SPLAT_NONE)
			required = WHITELIST_HUMAN
		else
			required = GLOB.splat_whitelists[splat_id]
		if(!isnull(required) && !preferences.has_whitelist(required))
			return FALSE
	return ..()
