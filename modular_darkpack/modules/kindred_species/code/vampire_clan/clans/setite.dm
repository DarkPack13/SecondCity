/datum/vampire_clan/setite
	name = "Setite"
	id = VAMPIRE_CLAN_SETITE
	desc = "The Followers of Set, also called the Ministry of Set, Ministry, or Setites, are a clan of vampires who believe their founder was the Egyptian god Set."
	curse = "Decreased moving speed in lighted areas."
	clan_disciplines = list(
		// /datum/discipline/obfuscate,
		// /datum/discipline/presence,
		// /datum/discipline/serpentis
	)
	male_clothes = /obj/item/clothing/under/vampire/slickback
	female_clothes = /obj/item/clothing/under/vampire/burlesque

/datum/vampire_clan/setite/on_gain(mob/living/carbon/human/vampire, joining_round)
	. = ..()
	//vampire.add_quirk(/datum/quirk/lightophobia)
	var/obj/item/organ/eyes/night_vision/NV = new()
	NV.Insert(vampire, TRUE, DELETE_IF_REPLACED)
