/datum/preference/choiced/subsplat/vampire_clan
	savefile_key = "vampire_clan"
	main_feature_name = "Clan"
	relevant_inherent_trait = TRAIT_VTM_CLANS

/datum/preference/choiced/subsplat/vampire_clan/init_possible_values()
	// DARKPACK TODO - implement whitelisting
	return assoc_to_keys(GLOB.vampire_clan_list)

/datum/preference/choiced/subsplat/vampire_clan/icon_for(value)
	return uni_icon('modular_darkpack/modules/vampire_the_masquerade/icons/vampire_clans.dmi', get_vampire_clan(value).id)

/datum/preference/choiced/subsplat/vampire_clan/apply_to_human(mob/living/carbon/human/target, value)
	target.set_clan(value, TRUE)
