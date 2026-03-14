/datum/subsplat/vampire_clan/brujah
	name = "Brujah"
	id = VAMPIRE_CLAN_BRUJAH
	desc = "The Brujah are a clan of radicals and troublemakers, Embracing those willing to put someone in their place if the situation calls for it. Most see themselves as warriors with a cause, and these Rebels are guided by their passions, strength, and dedication to their ideals — whatever those may be."
	icon = "brujah"
	curse = "Increased frenzy chances and time."
	sense_the_sin_text = "is cursed to anger for their shame at carthage.."
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/potence,
		/datum/discipline/presence
	)
	clan_traits = list(
		TRAIT_LONGER_FRENZY
	)
	male_clothes = /obj/item/clothing/under/vampire/brujah
	female_clothes = /obj/item/clothing/under/vampire/brujah/female
	subsplat_keys = /obj/item/vamp/keys/brujah

/datum/subsplat/vampire_clan/brujah/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()

