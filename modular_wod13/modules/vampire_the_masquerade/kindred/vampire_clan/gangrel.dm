/datum/vampire_clan/gangrel
	name = "Gangrel"
	id = VAMPIRE_CLAN_GANGREL
	desc = "Often closer to beasts than other vampires, the Gangrel style themselves apex predators. These Ferals prowl the wilds as easily as the urban jungle, and no clan of vampires can match their ability to endure, survive, and thrive in any environment. Often fiercely territorial, their shapeshifting abilities even give the undead pause."
	curse = "Start with lower humanity."
	/*
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/fortitude,
		/datum/discipline/protean
	)
	*/
	start_humanity = 6
	male_clothes = /obj/item/clothing/under/vampire/gangrel
	female_clothes = /obj/item/clothing/under/vampire/gangrel/female
	// TODO: [Lucia] re-add Clan accessories
	/*
	accessories = list("beast_legs", "beast_tail", "beast_tail_and_legs", "none")
	accessories_layers = list("beast_legs" = UNICORN_LAYER, "beast_tail" = UNICORN_LAYER, "beast_tail_and_legs" = UNICORN_LAYER, "none" = UNICORN_LAYER)
	*/
