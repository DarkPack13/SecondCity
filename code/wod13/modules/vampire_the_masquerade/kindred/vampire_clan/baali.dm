/datum/vampire_clan/baali
	name = "Baali"
	id = VAMPIRE_CLAN_BAALI
	desc = "The Baali are a bloodline of vampires associated with demon worship. Because of their affinity with the unholy, the Baali are particularly vulnerable to holy iconography, holy ground and holy water. They are highly vulnerable to True Faith."
	curse = "Fear of the Religion."
	/*
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/daimonion
	)
	*/
	clan_traits = list(
		TRAIT_REPELLED_BY_HOLINESS
	)
	male_clothes = /obj/item/clothing/under/vampire/baali
	female_clothes = /obj/item/clothing/under/vampire/baali/female
	enlightenment = TRUE
	whitelisted = TRUE
	clan_keys = /obj/item/vamp/keys/baali

/datum/vampire_clan/baali/on_gain(mob/living/carbon/human/H)
	. = ..()

	H.faction |= "Baali"

	H.AddElement(/datum/element/holy_weakness)

	H.gain_trauma(new /datum/brain_trauma/mild/phobia/religion, TRAUMA_RESILIENCE_ABSOLUTE)
