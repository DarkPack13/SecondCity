/datum/splat/fomori/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#554435", update = FALSE)
	human.set_hairstyle("Boddicker", update = TRUE)
	human.set_facial_hairstyle("Beard (Seven o Clock Shadow)", update = TRUE)
	human.set_eye_color("#8281ca")
	human.undershirt = "Tank Top (White)"
	human.update_body()
	human.equipOutfit(/datum/outfit/civillian4, TRUE)

/datum/splat/fomori/get_splat_description()
	return "Mortals who have lost themselves to the Wyrm's corruption. \
		A slow death of the self — most do not even realize what has happened to them before the bane takes over completely. \
		Tools of Dancers, and wretched things to mercifully be slain by Gaians. \
		You are but another pawn in a scheme older and grander than you could've ever imagined."

/datum/splat/fomori/get_splat_lore()
	return list(
		"The fomori are created when a Bane possesses a human or an animal via a spiritual \"hole\" left by some form of sin or spiritual corruption. The Bane will slowly gain more and more influence, until they are completely fused with the host and cannot be separated.",
	)

/datum/splat/fomori/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_BOOK_DEAD,
			SPECIES_PERK_NAME = "Bane Possession",
			SPECIES_PERK_DESC = "Fomori are possessed by spirits called Banes, which imbues them with various powers and taints.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_CROSSHAIRS,
			SPECIES_PERK_NAME = "Hunted and Subservient",
			SPECIES_PERK_DESC = "Fomori are hunted by Gaians and expected to serve the Wyrm.",
		),
	)

	return to_add
