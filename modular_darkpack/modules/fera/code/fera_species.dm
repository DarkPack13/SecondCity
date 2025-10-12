/datum/species/human/fera
	var/datum/action/innate/transformation/fera_transformation
	var/list/transformation_list = list()

/datum/species/human/fera/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons, replace_missing)
	. = ..()
	fera_transformation = new(human_who_gained_species, transformation_list)
	fera_transformation.Grant(human_who_gained_species)
