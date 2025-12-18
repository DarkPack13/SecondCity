/mob/living/carbon/human/proc/adjust_generation(mob/living/carbon/human/victim)
	var/new_generation = dna.species.generation
	if(victim.dna.species.generation < dna.species.generation)
		new_generation = max(dna.species.generation - 1, 7)
	dna.species.generation = new_generation

	if(!GLOB.canon_event)
		to_chat(src, span_warning("Cannot save generation preference; current round is not canon."))
	else
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/generation], new_generation)
