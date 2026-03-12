/datum/subsplat/vampire_clan/banu_haqim
	name = "Banu Haqim"
	id = VAMPIRE_CLAN_BANU_HAQIM
	desc = "Banu Haqim, also known as Assamites, are traditionally seen by Western Kindred as dangerous assassins and diablerists, but in truth they are guardians, warriors, and scholars who seek to distance themselves from the Jyhad."
	icon = "banu_haqim"
	curse = "Blood Addiction."
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/obfuscate,
		/datum/discipline/quietus
	)
	clan_traits = list(
		TRAIT_VITAE_ADDICTION
	)
	male_clothes = /obj/item/clothing/under/vampire/bandit
	female_clothes = /obj/item/clothing/under/vampire/bandit
	subsplat_keys = /obj/item/vamp/keys/banuhaqim

/datum/subsplat/vampire_clan/banu_haqim/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	sense_the_sin_text = "[gaining_mob.name] sees themselves as absolute judgement."
