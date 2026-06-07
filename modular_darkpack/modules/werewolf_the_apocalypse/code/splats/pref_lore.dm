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
			SPECIES_PERK_DESC = "Garou can shift between 5 diffrent forms that grant them bonuses.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_BAND_AID,
			SPECIES_PERK_NAME = "Passive healing",
			SPECIES_PERK_DESC = "Garou have a strong passive healing while outside of their breed form.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_MOON,
			SPECIES_PERK_NAME = "Silver weakness",
			SPECIES_PERK_DESC = "Silver weapons are unable to be soaked in non-breedforms and causes loss of Gnosis.",
		),
	)

	return to_add

/datum/splat/werewolf/shifter/corax/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#241e1c", update = FALSE)
	human.set_hairstyle("Long Over Eye", update = TRUE)
	human.undershirt = "Shirt (Black)"
	human.update_body()

/datum/splat/werewolf/shifter/corax/get_splat_description()
	return "Messengers of Gaia, children of Raven, and scions of Helios; the wereravens travel accross the globe, guided by their innate curiosity and insatiable thirst for gossip. \nThey are renowned for their ability to gather useful intelligence, and the difficulty of making them stop talking."

/datum/splat/werewolf/shifter/corax/get_splat_lore()
	return list(
		"Lorem Ipsum",
	)

/datum/splat/werewolf/shifter/corax/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_CROW,
			SPECIES_PERK_NAME = "Shapeshifting",
			SPECIES_PERK_DESC = "Corax can shift between 3 diffrent forms that grant them bonuses.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_BAND_AID,
			SPECIES_PERK_NAME = "Passive healing",
			SPECIES_PERK_DESC = "Corax have a strong passive healing while outside of their breed form.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_SUN,
			SPECIES_PERK_NAME = "Gold weakness",
			SPECIES_PERK_DESC = "Gold weapons is unable to be soaked in non-breedforms and causes loss of Gnosis.",
		),
	)

	return to_add
