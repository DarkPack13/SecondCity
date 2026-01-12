/**
 * Makes the mob a Kindred with the given Generation, Clan, morality, and sire.
 */
/mob/living/proc/make_kindred(generation = DEFAULT_GENERATION, datum/vampire_clan/clan, enlightenment, mob/living/sire)
	RETURN_TYPE(/datum/splat/vampire/kindred)

	return add_splat(/datum/splat/vampire/kindred, generation, clan, enlightenment, sire)

/**
 * Makes the mob a Kindred as if Embraced by another Kindred.
 *
 * Inherits Generation and Clan while always starting on Humanity morality.
 * Small chance for the childe to be a Caitiff independent of the sire's Clan.
 *
 * Arguments:
 * * sire - Kindred creating this Kindred
 * * always_same_clan - If there should be no chance the childe is a Caitiff
 */
/mob/living/proc/make_kindred_from_sire(mob/living/sire, always_same_clan = FALSE)
	RETURN_TYPE(/datum/splat/vampire/kindred)

	var/datum/splat/vampire/kindred/sire_splat = iskindred(sire)

	var/datum/vampire_clan/childe_clan = sire_splat.clan
	// 5% chance of childer being Caitiff instead of their sire's Clan
	if (!always_same_clan && prob(5))
		childe_clan = GLOB.vampire_clans[/datum/vampire_clan/caitiff]

	return make_kindred(sire_splat.generation + 1, childe_clan, FALSE, sire)
