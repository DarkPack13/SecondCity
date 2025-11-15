// DARKPACK EDIT ADD START
/datum/unit_test/apply_all_clans

/datum/unit_test/apply_all_clans/Run()
	var/datum/preferences/preferences = new(new /datum/client_interface)
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human/consistent)

	human.set_species(/datum/species/human/kindred)
	for(var/type in valid_subtypesof(/datum/vampire_clan))
		human.set_clan(type)
		TEST_ASSERT(istype(human.clan, type), "[type] was somehow not applied to human")
// DARKPACK EDIT ADD END
