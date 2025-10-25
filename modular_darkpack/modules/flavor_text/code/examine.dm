/mob/living/carbon
	///The Examine Panel TGUI.
	var/datum/examine_panel/tgui = new()
	//Custom examine text, set via IC verb.
	var/custom_examine_message = null

/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/carbon/holder

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_close(mob/user)
	// If this is an examine preview dummy, clean it up.
	if(istype(holder, /mob/living/carbon/human/dummy))
		qdel(holder)


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
	var/show_flavor_text_when_masked = user.client?.prefs.read_preference(/datum/preference/toggle/show_flavor_text_when_masked)

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) || (holder_human.head && (holder_human.head.flags_inv & HIDEFACE))

		//Check if the mob is obscured, then continue to headshot
		if((obscured || !holder_human.dna) && (!isobserver(user) || !show_flavor_text_when_masked))
			flavor_text = "Obscured"
			flavor_text_nsfw = "Obscured"
			character_notes = "Obscured"
			ooc_notes = "Obscured"
			name = "Unknown"
		else
			headshot = holder_human.dna.features[EXAMINE_DNA_HEADSHOT]
			flavor_text = holder_human.dna.features[EXAMINE_DNA_FLAVOR_TEXT]
			flavor_text_nsfw = holder.dna.features[EXAMINE_DNA_NSFW_FLAVOR_TEXT]
			ooc_notes = holder.dna.features[EXAMINE_DNA_OOC_NOTES]
			character_notes = holder.dna.features[EXAMINE_DNA_CHARACTER_NOTES]
			name = holder.name

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["flavor_text"] = flavor_text
	data["flavor_text_nsfw"] = flavor_text_nsfw
	data["ooc_notes"] = ooc_notes
	data["character_notes"] = character_notes
	data["headshot"] = headshot
	data["nsfw_content"] = nsfw_content ? TRUE : FALSE
	return data

/mob/living/carbon/proc/flavor_text_creation()
	var/flavor_text_to_show
	var/preview_text = copytext_char(dna.features[EXAMINE_DNA_FLAVOR_TEXT], 1, 110)
	// What examine_tgui.dm uses to determine if flavor text appears as "Obscured".
	var/face_obscured = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if(!face_obscured || (face_obscured && client?.prefs.read_preference(/datum/preference/toggle/show_flavor_text_when_masked)))
		flavor_text_to_show = span_notice("[preview_text]... <a href='byond://?src=[REF(src)];view_flavortext=1;'>\[Look closer?\]</a>")

	return flavor_text_to_show

/mob/living/carbon/human/dummy/proc/setup_examine_preview(mob/living/carbon/user)
	tgui.holder = user

/mob/living/carbon/Topic(href, href_list)
	if(href_list["view_flavortext"])
		// The examine preview dummy will be cleaned up once the user closes the TGUI window.
		var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy()
		mannequin.setup_examine_preview(src)
		mannequin.tgui?.ui_interact(usr)
