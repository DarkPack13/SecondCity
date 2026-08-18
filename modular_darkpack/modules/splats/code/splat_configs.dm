/// List of roundstart splats' their splat_id's
GLOBAL_LIST_EMPTY(roundstart_splats)

/datum/config_entry/keyed_list/roundstart_splats //splats you can play as from the get go.
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_FLAG

/datum/config_entry/keyed_list/roundstart_splats/ValidateListEntry(key_name, key_value)
	if(key_name in GLOB.splat_list)
		return TRUE

	log_config("ERROR: [key_name] is not a valid race ID.")
	return FALSE

/**
 * Checks if a splat is eligible to be picked at roundstart.
 *
 * Checks the config to see if this splat is allowed to be picked in the character setup menu.
 * Used by [/proc/generate_selectable_splat_and_languages].
 */
/datum/splat/proc/check_roundstart_eligible()
	if(id in (CONFIG_GET(keyed_list/roundstart_splats)))
		return TRUE
	return FALSE

/**
 * Generates splat available to choose in character setup at roundstart
 *
 * This proc generates which splat are available to pick from in character setup.
 * If there are no available roundstart splat, defaults to human.
 */
/proc/generate_selectable_splats()
	var/list/selectable_splat = list()

	for(var/splat_type in valid_subtypesof(/datum/splat))
		var/datum/splat/splat = GLOB.splat_prototypes[splat_type]
		if(splat.check_roundstart_eligible())
			selectable_splat += splat.id

	return selectable_splat

/// Gets a list of all splat id's available to choose in roundstart.
/proc/get_selectable_splats()
	RETURN_TYPE(/list)

	if (!GLOB.roundstart_splats.len)
		GLOB.roundstart_splats = generate_selectable_splats()

	return GLOB.roundstart_splats
