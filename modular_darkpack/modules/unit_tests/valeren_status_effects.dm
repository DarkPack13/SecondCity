/// Armor of Caine's Fury used to bail out of on_apply on any mob, so the
/// damage reduction never registered. Vengeance of Samiel passed its bonus
/// amount as the stat mod's source on removal, so the +5s were never removed.
/datum/unit_test/valeren_status_effects

/datum/unit_test/valeren_status_effects/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human/consistent)
	human.make_kindred()

	// Armor of Caine's Fury has to actually stick to a mob
	human.apply_status_effect(/datum/status_effect/armor_of_caines_fury, 3)
	TEST_ASSERT(human.has_status_effect(/datum/status_effect/armor_of_caines_fury), "Armor of Caine's Fury did not apply to a human")
	human.remove_status_effect(/datum/status_effect/armor_of_caines_fury)

	// Vengeance of Samiel has to give the stats back when it ends
	var/list/watched_stats = list(STAT_DEXTERITY, STAT_MELEE, STAT_BRAWL)
	var/list/baseline = list()
	for (var/stat in watched_stats)
		baseline[stat] = human.st_get_stat(stat, TRUE)

	human.apply_status_effect(/datum/status_effect/vengeance_of_samiel)
	for (var/stat in watched_stats)
		TEST_ASSERT(human.st_get_stat(stat, TRUE) > baseline[stat], "Vengeance of Samiel did not raise [stat]")

	human.remove_status_effect(/datum/status_effect/vengeance_of_samiel)
	for (var/stat in watched_stats)
		TEST_ASSERT_EQUAL(human.st_get_stat(stat, TRUE), baseline[stat], "Vengeance of Samiel left a permanent modifier on [stat]")
