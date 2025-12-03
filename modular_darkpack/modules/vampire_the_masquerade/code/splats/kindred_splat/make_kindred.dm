/mob/living/proc/make_kindred(generation = DEFAULT_GENERATION, datum/vampire_clan/clan, enlightenment, mob/living/sire)
	return add_splat(/datum/splat/vampire/kindred, generation, clan, enlightenment, sire)

/mob/living/proc/make_kindred_from_sire(mob/living/sire, always_same_clan = FALSE)
	var/datum/splat/vampire/kindred/sire_splat = iskindred(sire)

	var/datum/vampire_clan/childe_clan = sire_splat.clan
	// 5% chance of childer being Caitiff instead of their sire's Clan
	if (!always_same_clan && prob(5))
		childe_clan = GLOB.vampire_clans[/datum/vampire_clan/caitiff]

	return make_kindred(sire_splat.generation - 1, childe_clan, FALSE, sire)
