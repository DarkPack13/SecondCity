/datum/species/human/ghoul
	name = "Ghoul"
	plural_form = "Ghouls"
	id = SPECIES_GHOUL
	changesource_flags = MIRROR_BADMIN

/mob/living/carbon/human/species/ghoul
	race = /datum/species/human/ghoul

/datum/species/human/ghoul/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#ac151d", update = FALSE)
	human.set_hairstyle("Long Fringe", update = TRUE)
	human.set_eye_color("#2D4118")
	human.undershirt = "Tank Top (Fire)"
	human.update_body()

/datum/species/human/ghoul/on_species_gain(mob/living/carbon/human/new_ghoul, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()

	new_ghoul.make_ghoul()

/datum/species/human/ghoul/on_species_loss(mob/living/carbon/human/old_ghoul, datum/species/new_species, pref_load)
	. = ..()

	old_ghoul.remove_splat(/datum/splat/vampire/ghoul)
