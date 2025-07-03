/datum/preference/choiced/vampire_clan
	savefile_key = "vampire_clan"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Bloodline"
	relevant_inherent_trait = TRAIT_VTM_CLANS
	should_generate_icons = TRUE

/datum/preference/choiced/vampire_clan/init_possible_values()
	// TODO: [Lucia] implement whitelisting
	return assoc_to_keys(GLOB.vampire_clan_list)

/datum/preference/choiced/vampire_clan/icon_for(value)
	return uni_icon('icons/wod13/ui_icons/vampire_clans.dmi', get_vampire_clan(value).id)

/datum/preference/choiced/vampire_clan/apply_to_human(mob/living/carbon/human/target, value)
	target.set_clan(value, TRUE)

/datum/preference/choiced/vtm_morality
	savefile_key = "vtm_morality_path"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_WORLD_OF_DARKNESS
	main_feature_name = "Path"
	relevant_inherent_trait = TRAIT_VTM_MORALITY
	can_randomize = FALSE

/datum/preference/choiced/vtm_morality/create_default_value()
	return "Humanity"

/datum/preference/choiced/vtm_morality/init_possible_values()
	return list("Humanity", "Enlightenment")

/datum/preference/choiced/vtm_morality/apply_to_human(mob/living/carbon/human/target, value)
	if (!iskindred(target))
		return
	if (value != "Enlightenment")
		return

	var/datum/species/human/kindred/kindred_species = target.dna.species
	kindred_species.enlightenment = TRUE
