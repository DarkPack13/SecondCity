GLOBAL_LIST_INIT(bloodpool_by_gen, list(
	1000, // 1st (Caine, speculative)
	150, // 2nd (2nd Generation, speculative)
	100, // 3rd (Antediluvians, speculative)
	50, // 4th (Methuselahs)
	40, // 5th
	30, // 6th (Elders)
	20, // 7th
	15, // 8th
	14, // 9th (Ancillae)
	13, // 10th
	12, // 11th (Neonates)
	11, // 12th
	10, // 13th
	10, // 14th (Thin-Blooded)
	10, // 15th
	10 // 16th
))

GLOBAL_LIST_INIT(vitae_spending_rate_by_gen, list(
	10, // 1st (Caine, speculative)
	10, // 2nd (2nd Generation, speculative)
	10, // 3rd (Antediluvians, speculative)
	10, // 4th (Methuselahs)
	8, // 5th
	6, // 6th (Elders)
	4, // 7th
	3, // 8th
	2, // 9th (Ancillae)
	1, // 10th
	1, // 11th (Neonates)
	1, // 12th
	1, // 13th
	1, // 14th (Thin-Blooded)
	1, // 15th
	1 // 16th
))

/**
 * Get the maximum bloodpool for the given Kindred Generation as per V20 p. 270
 *
 * Arguments:
 * * gen - Generation to check
 */
/proc/get_max_bloodpool(gen)
	gen = clamp(gen, 1, length(GLOB.bloodpool_by_gen))
	return GLOB.bloodpool_by_gen[gen]

/**
 * Get the vitae spending rate for the given Kindred Generation as per V20 p. 270
 *
 * Arguments:
 * * gen - Generation to check
 */
/proc/get_vitae_spending_rate(gen)
	gen = clamp(gen, 1, length(GLOB.vitae_spending_rate_by_gen))
	return GLOB.vitae_spending_rate_by_gen[gen]

/**
 * Get the mob's Generation if they're a Kindred, or their effective Generation
 * if they're a Ghoul or some other splat.
 */
/mob/living/proc/get_generation()
	var/datum/splat/vampire/kindred/kindred = iskindred(src)
	if (!kindred)
		return isghoul(src) ? GHOUL_GENERATION : HUMAN_GENERATION

	return kindred.generation

/**
 * Set the Kindred's Generation and update bloodpool size and vitae spending
 * rates appropriately.
 */
/datum/splat/vampire/kindred/proc/set_generation(generation = DEFAULT_GENERATION)
	src.generation = generation

	update_bloodpool_size()

	update_vitae_spending_rate()

/**
 * Internal proc to update bloodpool size on Generation change.
 */
/datum/splat/vampire/kindred/proc/update_bloodpool_size()
	PRIVATE_PROC(TRUE)

	// Base human bloodpool + 3 for every Generation below 13
	owner.maxbloodpool = get_max_bloodpool(generation)
	owner.bloodpool = clamp(owner.bloodpool, 0, owner.maxbloodpool)
	owner.update_blood_hud()

/**
 * Internal proc to update vitae spending rate and its related abilities on
 * Generation change.
 */
/datum/splat/vampire/kindred/proc/update_vitae_spending_rate()
	PRIVATE_PROC(TRUE)

	vitae_spending_rate = get_vitae_spending_rate(generation)
	owner.change_st_power_level(/datum/discipline/bloodheal, vitae_spending_rate)
