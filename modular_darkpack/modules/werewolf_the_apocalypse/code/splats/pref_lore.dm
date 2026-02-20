/datum/splat/werewolf/kinfolk/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#C3BA88", update = FALSE)
	human.set_eye_color("B2B2B2", "B2B2B2")
	human.set_hairstyle("Bangs (Diagonal Alt)", update = TRUE)
	human.undershirt = "Shirt (Ian)"
	human.update_body()

// DARKPACK TODO - WEREWOLF - (len lore)
/datum/splat/werewolf/kinfolk/get_splat_description()
	return "Lorem Ipsum"

// DARKPACK TODO - WEREWOLF - (len lore)
/datum/splat/werewolf/kinfolk/get_splat_lore()
	return list(
		"Lorem Ipsum",
	)

/datum/splat/werewolf/shifter/garou/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#502D15", update = FALSE)
	human.set_hairstyle("Long Hair 3", update = TRUE)
	human.undershirt = "Shirt (Alien)"
	human.update_body()

// DARKPACK TODO - WEREWOLF - (len lore)
/datum/splat/werewolf/shifter/garou/get_splat_description()
	return "Lorem Ipsum"

// DARKPACK TODO - WEREWOLF - (len lore)
/datum/splat/werewolf/shifter/garou/get_splat_lore()
	return list(
		"Lorem Ipsum",
	)

/datum/splat/werewolf/shifter/garou/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_DOG,
			SPECIES_PERK_NAME = "Shapeshifting",
			SPECIES_PERK_DESC = "Garou can shift between 5 diffrent forms that grant them bonus.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_BAND_AID,
			SPECIES_PERK_NAME = "Passive healing",
			SPECIES_PERK_DESC = "Garou have a strong passive healing while outside of their breed form.",
		)
	)

	return to_add
