/datum/vampire_clan/gangrel
	name = "Gangrel"
	id = VAMPIRE_CLAN_GANGREL
	desc = "Often closer to beasts than other vampires, the Gangrel style themselves apex predators. These Ferals prowl the wilds as easily as the urban jungle, and no clan of vampires can match their ability to endure, survive, and thrive in any environment. Often fiercely territorial, their shapeshifting abilities even give the undead pause."
	icon = "gangrel"
	curse = "Start with lower humanity."
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/fortitude,
		/datum/discipline/protean
	)
	male_clothes = /obj/item/clothing/under/vampire/gangrel
	female_clothes = /obj/item/clothing/under/vampire/gangrel/female
	accessories = list("beast_legs", "beast_tail", "beast_tail_and_legs", "none")
	accessories_layers = list("beast_legs" = BODY_ADJ_LAYER, "beast_tail" = BODY_ADJ_LAYER, "beast_tail_and_legs" = BODY_ADJ_LAYER, "none" = BODY_ADJ_LAYER)

/datum/vampire_clan/gangrel/city
	name = "City Gangrel"
	id = VAMPIRE_CLAN_CITY_GANGREL
	icon = "city_gangrel"
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/obfuscate,
		/datum/discipline/protean
	)
