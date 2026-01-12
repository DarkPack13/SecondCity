/datum/preference/external_choiced/clan_mark
	savefile_key = "clan_mark"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_REQUIRES_CLAN
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES

/datum/preference/external_choiced/clan_mark/has_relevant_feature(datum/preferences/preferences)
	var/clan_type = preferences.read_preference(/datum/preference/choiced/vampire_clan)
	var/datum/vampire_clan/clan = get_vampire_clan(clan_type)
	if(!clan)
		return FALSE
	if(clan.accessories)
		return TRUE

/datum/preference/external_choiced/clan_mark/get_choices(datum/preferences/preferences)
	if(!preferences)
		return list("none")
	var/clan_type = preferences.read_preference(/datum/preference/choiced/vampire_clan)
	var/datum/vampire_clan/clan = get_vampire_clan(clan_type)
	if(!clan || !clan.accessories)
		return list("none")
	return clan.accessories

/datum/preference/external_choiced/clan_mark/create_informed_default_value(datum/preferences/preferences)
	return pick(get_choices(preferences))

/datum/preference/external_choiced/clan_mark/apply_to_human(mob/living/carbon/human/target, value)
	if(!value)
		return
	var/datum/vampire_clan/clan = target.get_clan()
	if(!length(clan?.accessories))
		return
	target.remove_overlay(clan.accessories_layers[value])
	var/mutable_appearance/acc_overlay = mutable_appearance('modular_darkpack/modules/kindred_species/icons/features.dmi', value, -clan.accessories_layers[value])
	target.overlays_standing[clan.accessories_layers[value]] = acc_overlay
	target.apply_overlay(clan.accessories_layers[value])
