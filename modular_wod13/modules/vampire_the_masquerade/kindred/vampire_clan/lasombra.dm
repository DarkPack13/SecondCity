/datum/vampire_clan/lasombra
	name = "Lasombra"
	id = VAMPIRE_CLAN_LASOMBRA
	desc = "The Lasombra exist for their own success, fighting for personal victories rather than solely for a crown to wear or a throne to sit upon. They believe that might makes right, and are willing to sacrifice anything to achieve their goals. A clan that uses spirituality as a tool rather than seeking honest enlightenment, their fickle loyalties are currently highlighted by half their clan's defection from the Sabbat."
	curse = "Technology refuse."
	/*
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/dominate,
		/datum/discipline/obtenebration
	)
	*/
	clan_traits = list(
		TRAIT_REJECTED_BY_TECHNOLOGY,
		TRAIT_NO_MIRROR_REFLECTION
	)
	male_clothes = /obj/item/clothing/under/vampire/emo
	female_clothes = /obj/item/clothing/under/vampire/business
	enlightenment = TRUE

/datum/vampire_clan/lasombra/on_gain(mob/living/carbon/human/H)
	. = ..()

	H.vis_flags |= VIS_HIDE
	H.faction |= "Lasombra"
