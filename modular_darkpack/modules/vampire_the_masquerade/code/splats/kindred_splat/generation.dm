/datum/splat/vampire/kindred/proc/set_generation(generation = DEFAULT_GENERATION)
	src.generation = generation

	update_bloodpool_size()

	update_vitae_spending_limit()

/datum/splat/vampire/kindred/proc/update_bloodpool_size()
	// Base human bloodpool + 3 for every Generation below 13
	owner.maxbloodpool = 10 + ((13 - generation) * 3)
	owner.bloodpool = clamp(owner.bloodpool, 0, owner.maxbloodpool)

/datum/splat/vampire/kindred/proc/update_vitae_spending_limit()
	// Level 1 at Generation 10+, level 2 at 9 and so on. May need to be adjusted to match tabletop Vitae spending rates better
	owner.change_st_power_level(/datum/discipline/bloodheal, clamp(11 - generation, 1, 10))

/mob/living/proc/get_generation()
	var/datum/splat/vampire/kindred/kindred = iskindred(src)
	if (!kindred)
		// Treat humans and other non-Kindred as just having a very high Generation
		return HUMAN_GENERATION

	return kindred.generation
