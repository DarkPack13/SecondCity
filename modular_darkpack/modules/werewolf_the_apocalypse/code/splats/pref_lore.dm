/datum/splat/werewolf/shifter/garou/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#502D15", update = FALSE)
	human.set_hairstyle("Long Hair 3", update = TRUE)
	human.undershirt = "Shirt (Alien)"
	human.update_body()

#warn len lore
/datum/splat/werewolf/shifter/garou/get_splat_description()
	return "Lorem Ipsum"

#warn len lore
/datum/splat/werewolf/shifter/garou/get_splat_lore()
	return list(
		"Lorem Ipsum",
	)

/*
/datum/splat/werewolf/shifter/garou/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "shield",
		SPECIES_PERK_NAME = "Garou",
		SPECIES_PERK_DESC = "Its a Garou.",
	))

	return to_add
*/
