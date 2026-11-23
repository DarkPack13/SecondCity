/mob/living/carbon
	///The Examine Panel TGUI.
	var/datum/examine_panel/examine_panel_tgui
	//Custom examine text, set via IC verb.
	var/custom_examine_message = null

/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/carbon/holder

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ExaminePanel")
		ui.open()


/datum/examine_panel/ui_data(mob/user)
	var/list/data = list()

	var/flavor_text = ""
	var/character_notes = ""
	var/obscured
	var/name = ""
	var/headshot = ""
	// Whether or not the viewing user wants to see potential NSFW content in the holder's examine panel
	var/nsfw_content = user.client?.prefs.read_preference(/datum/preference/toggle/nsfw_content_pref)
	var/flavor_text_nsfw = ""
	var/ooc_notes = ""
	var/show_flavor_text_when_masked = holder.client?.prefs.read_preference(/datum/preference/toggle/show_identity_when_masked)

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = holder_human.obscured_slots & HIDEFACE

		var/main_flavor_text_key = EXAMINE_DNA_FLAVOR_TEXT

		if(iscrinos(holder))
			main_flavor_text_key = EXAMINE_DNA_WAR_FORM_FLAVOR_TEXT
		else if(ishispo(holder) || islupus(holder))
			main_flavor_text_key = EXAMINE_DNA_FERAL_FORM_FLAVOR_TEXT

		//Check if the mob is obscured, then continue to headshot
		if(isobserver(user) || show_flavor_text_when_masked || !obscured)
			headshot = holder_human.dna.features[EXAMINE_DNA_HEADSHOT]
			flavor_text = holder_human.dna.features[main_flavor_text_key]
			flavor_text_nsfw = holder.dna.features[EXAMINE_DNA_NSFW_FLAVOR_TEXT]
			ooc_notes = holder.dna.features[EXAMINE_DNA_OOC_NOTES]
			character_notes = holder.dna.features[EXAMINE_DNA_CHARACTER_NOTES]
			name = holder.name
		else if(obscured || !holder_human.dna)
			flavor_text = "Obscured"
			flavor_text_nsfw = "Obscured"
			character_notes = "Obscured"
			ooc_notes = "Obscured"
			name = "Unknown"

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["flavor_text"] = flavor_text
	data["flavor_text_nsfw"] = CONFIG_GET(flag/nsfw_content) ? flavor_text_nsfw : null
	data["ooc_notes"] = CONFIG_GET(flag/nsfw_content) ? ooc_notes : null
	data["character_notes"] = character_notes
	data["headshot"] = headshot
	data["nsfw_content"] = nsfw_content ? TRUE : FALSE
	return data

/mob/living/carbon/proc/flavor_text_creation(mob/reader)
	var/main_flavor_text_key = EXAMINE_DNA_FLAVOR_TEXT
	if(iscrinos(src))
		main_flavor_text_key = EXAMINE_DNA_WAR_FORM_FLAVOR_TEXT
	else if(ishispo(src) || islupus(src))
		main_flavor_text_key = EXAMINE_DNA_FERAL_FORM_FLAVOR_TEXT

	var/preview_text
	if(flavortext_visible(reader))
		preview_text = copytext_char(dna.features[main_flavor_text_key], 1, FLAVOR_PREVIEW_LIMIT)
	return span_notice("[preview_text]... <a href='byond://?src=[REF(src)];view_flavortext=1;'>\[Look closer?\]</a>")

// What examine_tgui.dm uses to determine if flavor text appears as "Obscured".
/mob/living/carbon/proc/flavortext_visible(mob/user)
	if(isobserver(user))
		return TRUE
	var/face_obscured = obscured_slots & HIDEFACE
	if(face_obscured && !client?.prefs.read_preference(/datum/preference/toggle/show_identity_when_masked))
		return FALSE
	return TRUE

/mob/living/carbon/proc/has_examine_panel_info()
	var/static/list/all_flavor_text = list(
		EXAMINE_DNA_FLAVOR_TEXT,
		EXAMINE_DNA_WAR_FORM_FLAVOR_TEXT,
		EXAMINE_DNA_FERAL_FORM_FLAVOR_TEXT,
		EXAMINE_DNA_HEADSHOT,
		EXAMINE_DNA_NSFW_FLAVOR_TEXT,
		EXAMINE_DNA_OOC_NOTES,
		EXAMINE_DNA_CHARACTER_NOTES,
	)

	if(!dna?.features)
		return FALSE

	for(var/flavor_text in all_flavor_text)
		if(length(dna.features[flavor_text]))
			return TRUE

	return FALSE

/mob/living/carbon/Topic(href, href_list)
	if(href_list["view_flavortext"])
		if(!examine_panel_tgui)
			examine_panel_tgui = new()
			examine_panel_tgui.holder = src
		examine_panel_tgui.ui_interact(usr)
	. = ..()
