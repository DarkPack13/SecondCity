// TFN specific overrides for the admin discipline editor
/datum/admin_discipline_editor/ui_data(mob/user)
	var/list/data = ..()

	var/splat_path = target_prefs?.read_preference(/datum/preference/choiced/splats)
	if(!ispath(splat_path, /datum/splat/vampire))
		data["clan_name"] = null
		data["clan_disciplines"] = list()

	var/client/target_client = GLOB.directory[target_ckey]
	// if they have a value for screen_maps, they are in the character creator.
	// an admin shouldnt be editing the same slot at the same time or it will risk wiping the slot
	data["is_editing_character"] = target_client && length(target_client.screen_maps) > 0
	var/list/target_wl = target_prefs ? target_prefs.get_player_whitelists() : null
	data["player_whitelists"] = target_wl || list()
	data["whitelist_definitions"] = get_whitelist_definitions()

	return data

/datum/admin_discipline_editor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	switch(action)
		if("set_whitelist")
			if(!target_prefs)
				return FALSE
			var/whitelist_id = params["id"]
			if(!istext(whitelist_id) || !length(whitelist_id))
				return FALSE
			var/should_grant = text2num(params["grant"])
			if(should_grant)
				target_prefs.grant_whitelist(whitelist_id)
			else
				target_prefs.revoke_whitelist(whitelist_id)
			target_prefs.save_preferences()
			var/granted_revoked = should_grant ? "granted" : "revoked"
			message_admins("[key_name_admin(ui.user)] [granted_revoked] whitelist '[whitelist_id]' for [ADMIN_LOOKUPFLW(target_ckey)].")
			log_admin("[key_name_admin(ui.user)] [granted_revoked] whitelist '[whitelist_id]' for [ADMIN_LOOKUPFLW(target_ckey)].")
			SSoverwatch.record_action(null, "[key_name_admin(ui.user)] [granted_revoked] whitelist '[whitelist_id]' for [ADMIN_LOOKUPFLW(target_ckey)].")
			return TRUE

		// Intercept the old toggle_trusted action so it routes through the whitelist system.
		if("toggle_trusted")
			if(!target_prefs)
				return FALSE
			if(target_prefs.has_whitelist(WHITELIST_TRUSTED))
				target_prefs.revoke_whitelist(WHITELIST_TRUSTED)
			else
				target_prefs.grant_whitelist(WHITELIST_TRUSTED)
			target_prefs.save_preferences()
			message_admins("[key_name_admin(ui.user)] [target_prefs.has_whitelist(WHITELIST_TRUSTED) ? "granted" : "revoked"] trusted whitelist for [ADMIN_LOOKUPFLW(target_ckey)].")
			return TRUE

	return ..()
