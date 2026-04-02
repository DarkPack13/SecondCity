/datum/subsplat/vampire_clan/banu_haqim
	name = "Banu Haqim"
	id = VAMPIRE_CLAN_BANU_HAQIM
	desc = "Banu Haqim, also known as Assamites, are traditionally seen by Western Kindred as dangerous assassins and diablerists, but in truth they are guardians, warriors, and scholars who seek to distance themselves from the Jyhad."
	icon = "banu_haqim"
	curse = "Blood Addiction."
	sense_the_sin_text = "sees themselves as absolute judgement."
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

/datum/subsplat/vampire_clan/banu_haqim/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("An overwhelming presence manifests around me.."))
	new /obj/effect/client_image_holder/baali_demon/banu(get_turf(target), list(target))
