/datum/vampire_clan/salubri
	name = "Salubri"
	id = VAMPIRE_CLAN_SALUBRI
	desc = "The Salubri are one of the original 13 clans of the vampiric descendants of Caine. Salubri believe that vampiric existence is torment from which Golconda or death is the only escape. Consequently, the modern Salubri would Embrace, teach a childe the basics of the route, leave clues for the childe to follow to achieve Golconda, and then have their childe diablerize them."
	curse = "Hunted and consensual feeding."
	/*
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/fortitude,
		/datum/discipline/valeren
	)
	*/
	clan_traits = list(
		TRAIT_CONSENSUAL_FEEDING_ONLY,
		TRAIT_IRRESISTIBLE_VITAE
	)
	male_clothes = /obj/item/clothing/under/vampire/salubri
	female_clothes = /obj/item/clothing/under/vampire/salubri/female
	enlightenment = FALSE
	whitelisted = FALSE
	clan_keys = /obj/item/vamp/keys/salubri
