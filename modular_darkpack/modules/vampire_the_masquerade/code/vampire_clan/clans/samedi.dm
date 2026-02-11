/datum/vampire_clan/samedi
	name = "Samedi"
	id = VAMPIRE_CLAN_SAMEDI
	desc = "A rare bloodline of Corpse Walkers based from their enigmatic founder simply called the Baron Samedi."
	curse = "Extremely rotten dead form. Akin to a walking zombie."
	icon = "samedi"
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/fortitude,
		/datum/discipline/thanatosis
	)
	alt_sprite = "rotten4"
	clan_traits = list(
		TRAIT_MASQUERADE_VIOLATING_FACE
	)
	whitelisted = TRUE

/datum/vampire_clan/samedi/on_gain(mob/living/carbon/human/H)
	. = ..()
	H.rot_body(4)

/datum/vampire_clan/samedi/on_join_round(mob/living/carbon/human/H)
	. = ..()

	// Samedi Automatically Get the stuff to help them disguise themselves
	var/obj/item/clothing/suit/hooded/robes/darkred/new_robe = new(H.loc)
	H.equip_to_appropriate_slot(new_robe, FALSE)

	var/obj/item/clothing/mask/vampire/venetian_mask/fancy/new_mask = new(H.loc)
	H.equip_to_appropriate_slot(new_mask, FALSE)
