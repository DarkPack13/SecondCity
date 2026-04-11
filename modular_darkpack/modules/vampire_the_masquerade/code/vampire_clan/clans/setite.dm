/datum/subsplat/vampire_clan/setite
	name = "Setite"
	id = VAMPIRE_CLAN_SETITE
	desc = "The Followers of Set, also called the Ministry of Set, Ministry, or Setites, are a clan of vampires who believe their founder was the Egyptian god Set."
	icon = "setite"
	curse = "Decreased moving speed in lighted areas."
	sense_the_sin_text = "believes every stain of sin is a virtue."
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/serpentis
	)
	clan_traits = list(
		TRAIT_LIGHT_WEAKNESS
	)
	male_clothes = /obj/item/clothing/under/vampire/slickback
	female_clothes = /obj/item/clothing/under/vampire/burlesque

/datum/subsplat/vampire_clan/setite/tlacique
	name = "Tlacique"
	id = VAMPIRE_CLAN_TLACIQUE
	desc = "The Tlacique are a bloodline originating in Mexico, having been there long before the rest of the Setites showed up. They are dwindling in the modern day, nearly extinguished by the Sword of Caine, and oft only loosely resemble their parent clan."
	icon = "tlacique"
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/protean
	)
	whitelisted = TRUE

/datum/subsplat/vampire_clan/setite/warrior
	name = "Warrior Setite"
	id = VAMPIRE_CLAN_WARRIOR_SETITE
	icon = "warrior_setite"
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/presence,
		/datum/discipline/serpentis
	)
