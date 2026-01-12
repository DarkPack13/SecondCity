// DARKPACK EDIT ADD START
/datum/unit_test/apply_all_clans

/datum/unit_test/apply_all_clans/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human/consistent)

	human.mock_client = new /datum/client_interface()

	human.make_kindred()
	for(var/type in valid_subtypesof(/datum/vampire_clan))
		human.set_clan(type)
		TEST_ASSERT(human.is_clan(type), "[type] was somehow not applied to the human")

	// Verify there is no extra bugs when missing a client
	human.mock_client = null
	for(var/type in valid_subtypesof(/datum/vampire_clan))
		human.set_clan(type)
		TEST_ASSERT(human.is_clan(type), "[type] was somehow not applied to the human without a client")

// DARKPACK EDIT ADD END
