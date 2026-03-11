/// Preliminary wrapper for the prefs write_preference_midround that ensures your acctually on the same character as the one you spawned in as.
/mob/living/carbon/human/proc/write_preference_midround(datum/preference/preference, preference_value)
	if(!(client?.prefs))
		return FALSE
	if(!(mind?.original_character_slot_index))
		return FALSE

	var/mob/living/carbon/human/original_human = mind.original_character.resolve()

	if(!original_human || (original_human != src))
		return FALSE

	return client.prefs.write_preference_midround(GLOB.preference_entries[preference], preference_value, src)

/// Wrapper for write_preference to prevent writing for non-canon events like EORG
/// Returns TRUE for a successful preference application.
/// Returns FALSE if it is invalid or the round was not canon.
/datum/preferences/proc/write_preference_midround(datum/preference/preference, preference_value, mob/user)
	var/reason
	if(!GLOB.canon_event)
		reason = "current round is not canon."
	else if(!("[default_slot]" in parent.persistent_client.joined_as_slots))
		reason = "selected character sheet not spawned in."

	if(reason)
		to_chat(parent, span_warning("Cannot save preference: [preference.savefile_key]; [reason]"))
		user.log_message("failed to write pref: [preference.savefile_key] due to; [reason]", LOG_STATS)
		return FALSE

	user.log_message("wrote to pref '[preference.savefile_key]' midround. set to '[preference_value]'", LOG_STATS)
	return write_preference(preference, preference_value)
