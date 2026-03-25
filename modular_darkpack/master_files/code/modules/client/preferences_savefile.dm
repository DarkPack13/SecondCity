/datum/preferences
	// List of known guestbook names we have saved
	var/list/guestbook_names = list()

/datum/preferences/load_preferences()
	discipline_trusted = savefile.get_entry("discipline_trusted", FALSE) // deserialization and its consequences
	. = ..()

/datum/preferences/save_preferences()
	savefile.set_entry("discipline_trusted", discipline_trusted) // since existing load/save is per character, save and load it from a level above that
	. = ..()

/datum/preferences/load_character(slot)
	. = ..()
	var/tree_key = "character[default_slot]"
	var/list/save_data = savefile.get_entry(tree_key)

	// We don't really need to do any validation since that's all done in the parent proc.

	guestbook_names = save_data?["guestbook_names"]
	guestbook_names = SANITIZE_LIST(guestbook_names)
	alt_job_titles = save_data?["alt_job_titles"] // ALTERNATIVE_JOB_TITLES
	discipline_levels = SANITIZE_LIST(save_data?["discipline_levels"]) || list()

/datum/preferences/save_character()
	. = ..()
	var/tree_key = "character[default_slot]"
	if(!(tree_key in savefile.get_entry()))
		savefile.set_entry(tree_key, list())
	var/save_data = savefile.get_entry(tree_key)

	save_data["guestbook_names"] = guestbook_names
	save_data["alt_job_titles"] = alt_job_titles // ALTERNATIVE_JOB_TITLES
	save_data["discipline_levels"] = discipline_levels
	savefile.save()
