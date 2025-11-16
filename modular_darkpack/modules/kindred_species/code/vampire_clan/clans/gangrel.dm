/datum/vampire_clan/gangrel
	name = "Gangrel"
	id = VAMPIRE_CLAN_GANGREL
	desc = "Often closer to beasts than other vampires, the Gangrel style themselves apex predators. These Ferals prowl the wilds as easily as the urban jungle, and no clan of vampires can match their ability to endure, survive, and thrive in any environment. Often fiercely territorial, their shapeshifting abilities even give the undead pause."
	curse = "Start with lower humanity."
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/fortitude,
		/datum/discipline/protean
	)
	start_humanity = 6
	male_clothes = /obj/item/clothing/under/vampire/gangrel
	female_clothes = /obj/item/clothing/under/vampire/gangrel/female
	accessories = list("beast_legs", "beast_tail", "beast_tail_and_legs", "none")
	accessories_layers = list("beast_legs" = BODY_ADJ_LAYER, "beast_tail" = BODY_ADJ_LAYER, "beast_tail_and_legs" = BODY_ADJ_LAYER, "none" = BODY_ADJ_LAYER)

/*
/datum/vampire_clan/gangrel/city
	name = "City Gangrel"
	id = VAMPIRE_CLAN_CITY_GANGREL
	/*
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/obfuscate,
		/datum/discipline/protean
	)
	*/
*/

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
	if(!length(target.clan?.accessories))
		return
	target.remove_overlay(target.clan.accessories_layers[value])
	var/mutable_appearance/acc_overlay = mutable_appearance('modular_darkpack/modules/kindred_species/icons/features.dmi', value, -target.clan.accessories_layers[value])
	target.overlays_standing[target.clan.accessories_layers[value]] = acc_overlay
	target.apply_overlay(target.clan.accessories_layers[value])
