/datum/preference/choiced/zulo_form
	savefile_key = "zulo_form"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	priority = PREFERENCE_PRIORITY_REQUIRES_CLAN
	main_feature_name = "Zulo Form"
	should_generate_icons = TRUE

/datum/preference/choiced/zulo_form/has_relevant_feature(datum/preferences/preferences)
	. = ..()
	if(!.) // Make sure we acctually can select clan in the first place
		return FALSE
	var/clan_type = preferences.read_preference(/datum/preference/choiced/vampire_clan)
	var/datum/vampire_clan/clan = get_vampire_clan(clan_type)
	if(!clan)
		return FALSE
	for(var/discipline in clan.clan_disciplines) // DARKPACK TODO - reimplement choosing disciplines
		if(ispath(discipline, /datum/discipline/vicissitude))
			return TRUE
	return FALSE

/datum/preference/choiced/zulo_form/init_possible_values()
	return assoc_to_keys(GLOB.zulo_forms)

/datum/preference/choiced/zulo_form/icon_for(value)
	var/icon_state = GLOB.zulo_forms[value]
	var/datum/universal_icon/zulo_icon = uni_icon('modular_darkpack/modules/powers/icons/zulo_forms.dmi', icon_state)
	zulo_icon.scale(32, 32)
	return zulo_icon

/datum/preference/choiced/zulo_form/apply_to_human(mob/living/carbon/human/target, value)
	return
