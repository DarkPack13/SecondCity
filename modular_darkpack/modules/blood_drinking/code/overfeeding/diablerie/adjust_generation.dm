/mob/living/carbon/human/proc/adjust_generation(mob/living/carbon/human/victim)
	var/datum/splat/vampire/kindred/kindred = iskindred(src)
	var/generation = get_generation()
	var/victim_generation = victim.get_generation()

	var/new_generation = generation
	if(victim_generation < generation)
		new_generation = max(generation - 1, MAX_TRUSTED_GENERATION)
	kindred.set_generation(new_generation)

	if(!GLOB.canon_event)
		to_chat(src, span_warning("Cannot save generation preference; current round is not canon."))
	else
		client.prefs.write_preference(GLOB.preference_entries[/datum/preference/numeric/generation], new_generation)
