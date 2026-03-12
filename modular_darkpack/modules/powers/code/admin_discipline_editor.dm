#define TRUSTED_DISC_PATH "data/discipline_trusted.json"

/datum/admin_discipline_editor
	var/target_ckey = ""
	var/selected_slot = 0
	var/datum/preferences/target_prefs = null
	var/loaded_offline = FALSE
	var/not_found = FALSE
	var/list/discipline_cache = null
	var/is_trusted = FALSE

/datum/admin_discipline_editor/Destroy()
	if(loaded_offline)
		QDEL_NULL(target_prefs)
	target_prefs = null
	return ..()

/datum/admin_discipline_editor/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AdminDisciplineEditor")
		ui.open()

/datum/admin_discipline_editor/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/admin_discipline_editor/ui_data(mob/user)
	var/list/data = list()
	data["target_ckey"] = target_ckey
	data["selected_slot"] = selected_slot
	data["not_found"] = not_found
	data["is_trusted"] = is_trusted
	data["character_slots"] = list()
	data["discipline_levels"] = list()
	data["clan_disciplines"] = list()
	data["disciplines"] = build_discipline_cache()
	data["discipline_validation"] = null

	if(target_prefs)
		var/list/profiles = target_prefs.create_character_profiles()
		for(var/i in 1 to target_prefs.max_save_slots)
			data["character_slots"] += profiles[i] || "Slot [i]"

		if(selected_slot > 0)
			var/list/clan_discs = list()
			for(var/disc_path in target_prefs.discipline_levels)
				data["discipline_levels"]["[disc_path]"] = target_prefs.discipline_levels[disc_path]

			var/clan_value = target_prefs.read_preference(/datum/preference/choiced/subsplat/vampire_clan)
			if(clan_value)
				var/datum/subsplat/vampire_clan/clan_datum = get_vampire_clan(clan_value)
				if(clan_datum)
					for(var/disc_type in clan_datum.clan_disciplines)
						if(ispath(disc_type, /datum/discipline))
							var/disc_str = "[disc_type]"
							data["clan_disciplines"] += disc_str
							clan_discs += disc_str

			data["discipline_validation"] = validate_discipline_sheet(target_prefs.discipline_levels, clan_discs, is_trusted)

	return data

/datum/admin_discipline_editor/proc/build_discipline_cache()
	if(discipline_cache)
		return discipline_cache

	discipline_cache = list()
	for(var/discipline_type in subtypesof(/datum/discipline))
		var/datum/discipline/discipline = new discipline_type
		if(!discipline.selectable)
			qdel(discipline)
			continue
		if(ispath(discipline_type, /datum/discipline/path))
			qdel(discipline)
			continue
		var/list/disc_data = list()
		disc_data["name"] = discipline.name
		disc_data["desc"] = discipline.desc
		disc_data["max_level"] = length(discipline.all_powers)
		disc_data["rarity"] = (discipline_type in RARE_DISCIPLINE_TYPES) ? "rare" : "common"
		var/icon/disc_icon = icon('modular_darkpack/modules/deprecated/icons/ui/actions.dmi', discipline.icon_state)
		if(disc_icon)
			disc_data["icon_b64"] = icon2base64(disc_icon)
		discipline_cache["[discipline_type]"] = disc_data
		qdel(discipline)

	return discipline_cache

/datum/admin_discipline_editor/proc/load_trusted_list()
	if(!fexists(TRUSTED_DISC_PATH))
		return list()
	return json_decode(file2text(TRUSTED_DISC_PATH)) || list()

/datum/admin_discipline_editor/proc/save_trusted_list(list/trusted)
	rustg_file_write(json_encode(trusted), TRUSTED_DISC_PATH)

/datum/admin_discipline_editor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("search_ckey")
			var/search = params["ckey"]
			if(!search)
				return FALSE
			search = ckey(search)
			not_found = !load_target(search)
			return TRUE

		if("select_slot")
			if(!target_prefs)
				return FALSE
			var/slot = round(text2num(params["slot"]))
			if(!slot)
				return FALSE
			slot = clamp(slot, 1, target_prefs.max_save_slots)
			target_prefs.load_character(slot)
			target_prefs.default_slot = slot
			selected_slot = slot
			return TRUE

		if("set_discipline_level")
			if(!target_prefs || !selected_slot)
				return FALSE
			var/disc_path = params["discipline"]
			var/new_level = text2num(params["level"])
			if(!disc_path || isnull(new_level))
				return FALSE
			new_level = round(new_level)
			if(new_level < 0 || new_level > 5)
				return FALSE
			if(new_level == 0)
				target_prefs.discipline_levels -= disc_path
			else
				target_prefs.discipline_levels[disc_path] = new_level
			target_prefs.save_character()
			return TRUE

		if("toggle_trusted")
			if(!target_ckey)
				return FALSE
			var/list/trusted = load_trusted_list()
			if(is_trusted)
				trusted -= target_ckey
				is_trusted = FALSE
			else
				trusted |= target_ckey
				is_trusted = TRUE
			save_trusted_list(trusted)
			message_admins("[ui.user] [is_trusted ? "granted" : "revoked"] trusted discipline whitelist for [target_ckey].")
			return TRUE

/datum/admin_discipline_editor/proc/load_target(search_ckey)
	if(loaded_offline && target_prefs)
		qdel(target_prefs)
		target_prefs = null
		loaded_offline = FALSE

	target_ckey = search_ckey
	selected_slot = 0

	var/list/trusted = load_trusted_list()
	is_trusted = (search_ckey in trusted)

	var/client/found_client = GLOB.directory[search_ckey]
	if(found_client?.prefs)
		target_prefs = found_client.prefs
		loaded_offline = FALSE
		selected_slot = target_prefs.default_slot
		return TRUE
	var/prefs_path = "data/player_saves/[search_ckey[1]]/[search_ckey]/preferences.json"
	if(!fexists(prefs_path))
		return FALSE
	var/datum/client_interface/mock = new
	mock.ckey = search_ckey
	mock.key = search_ckey
	var/datum/preferences/offline_prefs = new(mock)
	offline_prefs.load_character(1)
	offline_prefs.default_slot = 1
	target_prefs = offline_prefs
	loaded_offline = TRUE
	selected_slot = 1
	return TRUE

ADMIN_VERB(teach_discipline, R_ADMIN, "Discipline Menu", "Edit a player's disciplines.", ADMIN_CATEGORY_SECOND_CITY)
	var/datum/admin_discipline_editor/editor = new
	editor.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Discipline Menu")
