/datum/species/human/fera
	name = "Fera"
	plural_form = "Fera"
	id = SPECIES_FERA
	var/datum/action/cooldown/spell/shapeshift/transformation/fera_transformation
	var/list/transformation_list = list()

/datum/species/human/fera/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons, replace_missing)
	. = ..()
	if(istype(old_species, /datum/species/human/fera))
		return
	fera_transformation = new(human_who_gained_species, transformation_list)
	fera_transformation.Grant(human_who_gained_species)

/datum/species/human/fera/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	fera_transformation.Remove(human)
	QDEL_NULL(fera_transformation)

