// Base type for all transformations for fera, such as corax and garou.
/mob/living/carbon/human/fera
	rotate_on_lying = FALSE
	initial_language_holder = /datum/language_holder/primal
	var/race = /datum/species/human/fera

/mob/living/carbon/human/fera/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_JUMPSUIT, "Fera")

/mob/living/carbon/human/fera/create_dna()
	dna = new /datum/dna(src)
	dna.species = new race

/mob/living/carbon/human/fera/update_damage_overlays() //fera don't have damage overlays.
	return

/mob/living/carbon/human/fera/update_body(is_creating = FALSE) // we don't use the bodyparts or body layers for fera.
	return

/mob/living/carbon/human/fera/update_body_parts() //we don't use the bodyparts layer for fera.
	return
