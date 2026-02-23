// Make sure there are no runtimes or other failures in adding and removing splats without arguments
/datum/unit_test/apply_all_splats

/datum/unit_test/apply_all_splats/Run()
	var/list/all_splat_types = valid_subtypesof(/datum/splat)

	// Create a mock NPC to apply splats to
	var/mob/living/carbon/human/consistent/npc = EASY_ALLOCATE()
	npc.mind_initialize()
	test_applying_splats(npc, all_splat_types, "NPC")

	// Create a mock player to apply splats to
	var/mob/living/carbon/human/consistent/player = EASY_ALLOCATE()
	player.mind_initialize()
	var/datum/client_interface/player_client = new()
	player.mock_client = player_client
	player_client.mob = player
	player_client.prefs = new(player_client)
	test_applying_splats(player, all_splat_types, "player")

/datum/unit_test/apply_all_splats/proc/test_applying_splats(mob/living/carbon/human/dummy, list/splat_types, dummy_type)
	for (var/splat_type in splat_types)
		// Failing to add or get a splat will continue with others, failing to remove will cancel the entire test
		var/datum/splat/adding_splat = dummy.add_splat(splat_type)
		if (!adding_splat)
			TEST_FAIL("Failed to add splat [splat_type] to mock [dummy_type].")
			continue

		var/datum/splat/gotten_splat = dummy.get_splat(splat_type)
		if (!gotten_splat)
			TEST_FAIL("Failed to get previously added splat [splat_type] from mock [dummy_type].")
			continue

		var/remove_success = dummy.remove_splat(splat_type)
		TEST_ASSERT(remove_success, "Failed to remove splat [splat_type] from mock [dummy_type].")



/datum/unit_test/splat_prio_validation

// Might want to acctually add EVERY splat that exists on the same index rather then just taking the first but it felt pretty overkill.
/datum/unit_test/splat_prio_validation/Run()
	var/list/all_splat_types = valid_subtypesof(/datum/splat)

	var/alist/splat_prio_list = alist()
	for(var/datum/splat/splat_type as anything in all_splat_types)
		var/splat_prio = splat_type::splat_priority
		if(!splat_prio_list["[splat_prio]"])
			splat_prio_list["[splat_prio]"] = splat_type
		else
			var/datum/splat/checking_type = splat_prio_list["[splat_prio]"]
			var/datum/splat/real_splat = GLOB.splat_prototypes[checking_type::id]
			if(splat_type in real_splat.incompatible_splats)
				continue
			TEST_FAIL("[splat_type] has the same splat priority as [splat_prio_list["[splat_prio]"]] yet is somehow compatible. priority is [splat_prio].")

