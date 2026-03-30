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
	return data
