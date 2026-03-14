/datum/subsplat/vampire_clan/setite
	name = "Setite"
	id = VAMPIRE_CLAN_SETITE
	desc = "The Followers of Set, also called the Ministry of Set, Ministry, or Setites, are a clan of vampires who believe their founder was the Egyptian god Set."
	icon = "followers_of_set"
	curse = "Decreased moving speed in lighted areas."
	sense_the_sin_text = "believes every stain of sin is a virtue."
	signature_discipline = /datum/discipline/serpentis
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/serpentis
	)
	male_clothes = /obj/item/clothing/under/vampire/slickback
	female_clothes = /obj/item/clothing/under/vampire/burlesque

/datum/subsplat/vampire_clan/setite/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	//gaining_mob.add_quirk(/datum/quirk/lightophobia)

