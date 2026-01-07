/// Wrapper for write_preference to prevent writing for non-canon events like EORG
/// Returns TRUE for a successful preference application.
/// Returns FALSE if it is invalid or the round was not canon.
/datum/preferences/proc/write_preference_midround(datum/preference/preference, preference_value)
	if(!GLOB.canon_event)
		to_chat(parent, span_warning("Cannot save preference: [preference.savefile_key]; current round is not canon."))
		return FALSE
	return write_preference(preference, preference_value)
