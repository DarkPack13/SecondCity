/datum/preference/choiced/subsplat/garou_auspice
	savefile_key = "garou_auspice"
	main_feature_name = "Auspice"
	relevant_inherent_trait = TRAIT_WTA_GAROU_AUSPICE

/datum/preference/choiced/subsplat/garou_auspice/init_possible_values()
	return assoc_to_keys(GLOB.auspices_list) // This would be inclusive of ALL auspices so many need to be reworked when adding other fera

/datum/preference/choiced/subsplat/garou_auspice/icon_for(value)
	var/datum/universal_icon/auspice_icon = uni_icon('icons/effects/effects.dmi', "nothing")
	auspice_icon.blend_icon(uni_icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/auspices.dmi', replacetext(LOWER_TEXT(value), " ", "_")), ICON_OVERLAY)
	return auspice_icon

/datum/preference/choiced/subsplat/garou_auspice/apply_to_human(mob/living/carbon/human/target, value)
	target.set_auspice(value, TRUE)
