/*
 * Runs an extended suite of eligibility checks to make sure the player can take the requested job.
 *
 * Checks:
 * * Species Availability
 * * Species Slots
 * * Whitelist - TODO
 * * Kindred Age
 * * Kindred Generation
 * * Kindred Clan
 *
 * Arguments:
 * * player - The player to check for job eligibility.
 * * possible_job - The job to check for eligibility against.
 * * debug_prefix - Logging prefix for the job_debug log entries. For example, GRJ during give_random_job or DO during divide_occupations.
 * * add_job_to_log - If TRUE, appends the job type to the log entry. If FALSE, does not. Set to FALSE when check is part of iterating over players for a specific job, set to TRUE when check is part of iterating over jobs for a specific player and you don't want extra log entry spam.
 */
/datum/controller/subsystem/job/proc/check_job_eligibility_darkpack(mob/dead/new_player/player, datum/job/possible_job, debug_prefix = "", add_job_to_log = FALSE)
	var/client/player_client = GET_CLIENT(player)
	var/datum/species/player_species = GLOB.species_prototypes[player_client.prefs.read_preference(/datum/preference/choiced/species)]
	var/player_species_id = player_species.id

	if(!(player_species_id in possible_job.allowed_species))
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_SPECIES, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_SPECIES

	if(possible_job.species_slots[player_species_id] == 0)
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_SPECIES_SLOTS, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_SPECIES_SLOTS

	/*
	if(possible_job.whitelisted)
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_WHITELIST, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_WHITELIST
	*/

	if(player_species_id != SPECIES_KINDRED)
		return JOB_AVAILABLE
	// Beyond this point, we know our species is a kindred.

	if((player_client.prefs.read_preference(/datum/preference/numeric/immortal_age) < possible_job.minimum_immortal_age))
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_KINDRED_AGE, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_KINDRED_AGE

	if((player_client.prefs.read_preference(/datum/preference/numeric/generation) > possible_job.minimal_generation))
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_KINDRED_GENERATION, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_KINDRED_GENERATION

	var/datum/vampire_clan/clan = get_vampire_clan(player_client.prefs.read_preference(/datum/preference/choiced/vampire_clan))
	if(possible_job.allowed_clans && !(clan.id in possible_job.allowed_clans))
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_KINDRED_CLAN, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_KINDRED_CLAN
	if(possible_job.disallowed_clans && (clan.id in possible_job.disallowed_clans))
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_KINDRED_CLAN, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_KINDRED_CLAN

	return JOB_AVAILABLE

