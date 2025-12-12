/datum/preferences
	// List of known guestbook names we have saved
	var/list/guestbook_names = list()

/datum/preferences/load_character(slot)
	. = ..()
	var/tree_key = "character[slot]"
	var/list/save_data = savefile.get_entry(tree_key)

	// We don't really need to do any validation since that's all done in the parent proc.

	guestbook_names = save_data?["guestbook_names"]
	guestbook_names = SANITIZE_LIST(guestbook_names)

/datum/preferences/save_character()
	. = ..()
	var/tree_key = "character[default_slot]"
	if(!(tree_key in savefile.get_entry()))
		savefile.set_entry(tree_key, list())
	var/save_data = savefile.get_entry(tree_key)

	save_data["guestbook_names"] = guestbook_names
