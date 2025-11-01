/datum/controller/subsystem/job/proc/FreeRole(mob/living/carbon/despawning_mob)
	var/datum/job/job_datum = despawning_mob.mind.assigned_role
	if(!job_datum)
		return
	job_debug("Freeing role: [job_datum.title]")
	job_datum.current_positions = max(0, job_datum.current_positions - 1)

	var/datum/species/player_species = despawning_mob.dna?.species
	var/player_species_id = player_species?.id
	if(job_datum.species_slots[player_species_id] >= 0)
		job_datum.species_slots[player_species_id] = job_datum.species_slots[player_species_id] + 1
