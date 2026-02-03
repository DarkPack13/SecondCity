// Generic helpers to simulate the healing of the TTRPG

/// Returns amount of dots healed
/mob/living/proc/heal_storyteller_health(dots_to_heal, heal_aggravated = FALSE, heal_scars = FALSE)
	if(dots_to_heal <= 0)
		return 0

	var/healed_dots = 0

	if(heal_aggravated)
		while(dots_to_heal > 0 && get_agg_loss() > 0)
			adjust_agg_loss(-1 TTRPG_DAMAGE, FALSE)
			dots_to_heal--
			healed_dots++
		while(dots_to_heal > 0 && get_fire_loss() > 0)
			adjust_fire_loss(-1 TTRPG_DAMAGE, FALSE)
			dots_to_heal--
			healed_dots++

	while(dots_to_heal > 0 && get_brute_loss() > 0)
		adjust_brute_loss(-1 TTRPG_DAMAGE, FALSE)
		dots_to_heal--
		healed_dots++

	if(heal_scars && dots_to_heal > 0)
		healed_dots += heal_storyteller_scars(dots_to_heal)

	if(healed_dots)
		updatehealth()

	return healed_dots

/mob/living/proc/heal_storyteller_scars(dots_to_heal)
	return

/mob/living/carbon/heal_storyteller_scars(dots_to_heal)
	var/healed_dots = 0

	for(var/datum/wound/our_wound in all_wounds)
		if(dots_to_heal <= 0)
			break
		our_wound.remove_wound()
		dots_to_heal--
		healed_dots++

	return healed_dots
