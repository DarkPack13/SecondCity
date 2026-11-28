/mob/living/carbon/human/npc/sabbat
	var/list/possible_clan = list(
		/datum/subsplat/vampire_clan/toreador,
		/datum/subsplat/vampire_clan/brujah,
		/datum/subsplat/vampire_clan/malkavian,
		/datum/subsplat/vampire_clan/gangrel
	)

/mob/living/carbon/human/npc/sabbat/Initialize(mapload)
	. = ..()
	make_kindred(generation = 12)
	set_clan(pick(possible_clan))

	SSpoints_of_interest.make_point_of_interest(src)

/mob/living/carbon/human/npc/sabbat/get_socialrole_type()
	return pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale)

/mob/living/carbon/human/npc/sabbat/shovelhead
	name = "Shovelhead"

/mob/living/carbon/human/npc/sabbat/shovelhead/toreador
	possible_clan = list(/datum/subsplat/vampire_clan/toreador)
/mob/living/carbon/human/npc/sabbat/shovelhead/brujah
	possible_clan = list(/datum/subsplat/vampire_clan/brujah)
/mob/living/carbon/human/npc/sabbat/shovelhead/malkavian
	possible_clan = list(/datum/subsplat/vampire_clan/malkavian)
/mob/living/carbon/human/npc/sabbat/shovelhead/gangrel
	possible_clan = list(/datum/subsplat/vampire_clan/gangrel)
