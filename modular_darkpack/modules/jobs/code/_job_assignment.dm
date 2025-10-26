/*
 * Runs an extended suite of eligibility checks to make sure the player can take the reqeusted job.
 *
 * Checks:
 * * Species Availability
 * * Species Slots
 * * Whitelist
 * * Kindred Age
 * * Kindred Generation
 * * Kindred Clan
 * * Garou Tribe
 * * Garou Auspice
 *
 * Arguments:
 * * player - The player to check for job eligibility.
 * * possible_job - The job to check for eligibility against.
 * * debug_prefix - Logging prefix for the job_debug log entries. For example, GRJ during give_random_job or DO during divide_occupations.
 * * add_job_to_log - If TRUE, appends the job type to the log entry. If FALSE, does not. Set to FALSE when check is part of iterating over players for a specific job, set to TRUE when check is part of iterating over jobs for a specific player and you don't want extra log entry spam.
 */
/datum/controller/subsystem/job/proc/check_job_eligibility_darkpack(mob/dead/new_player/player, datum/job/possible_job, debug_prefix = "", add_job_to_log = FALSE)
	var/client/player_client = GET_CLIENT(player)
	if(player_client.prefs.read_preference(/datum/preference/choiced/species) in possible_job.species_slots)
		job_debug("[debug_prefix] Error: [get_job_unavailable_error_message(JOB_UNAVAILABLE_SPECIES, possible_job.title)], Player: [player][add_job_to_log ? ", Job: [possible_job]" : ""]")
		return JOB_UNAVAILABLE_SPECIES

	return JOB_AVAILABLE

