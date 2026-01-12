/mob/living/carbon/human/proc/adjust_generation(mob/living/carbon/human/victim)
	var/new_generation = dna.species.generation
	if(victim.dna.species.generation < dna.species.generation)
		new_generation = max(dna.species.generation - 1, 7)
	dna.species.generation = new_generation

	client.prefs.write_preference_midround(GLOB.preference_entries[/datum/preference/numeric/generation], new_generation)
