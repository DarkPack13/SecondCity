//TODO - HEX, swap out with new ghoul species when the time is right
/datum/species/human/ghoul
	name = "Ghoul"
	plural_form = "Ghouls"
	id = SPECIES_GHOUL
	inherent_traits = list(TRAIT_USES_SKINTONES, TRAIT_ADVANCEDTOOLUSER, TRAIT_NOCRITDAMAGE)
	var/mob/living/carbon/human/master
	var/changed_master = FALSE
	var/last_vitae = 0
	var/list/datum/discipline/disciplines = list()
