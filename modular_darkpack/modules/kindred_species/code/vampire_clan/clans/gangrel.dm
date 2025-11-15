/datum/vampire_clan/gangrel
	name = "Gangrel"
	id = VAMPIRE_CLAN_GANGREL
	desc = "Often closer to beasts than other vampires, the Gangrel style themselves apex predators. These Ferals prowl the wilds as easily as the urban jungle, and no clan of vampires can match their ability to endure, survive, and thrive in any environment. Often fiercely territorial, their shapeshifting abilities even give the undead pause."
	curse = "Start with lower humanity."
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/fortitude,
		// /datum/discipline/protean
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


/datum/preference/choiced/clan_mark
	savefile_key = "clan_mark"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES

/datum/preference/choiced/clan_mark/has_relevant_feature(datum/preferences/preferences)
	var/clan_type = preferences.read_preference(/datum/preference/choiced/vampire_clan)
	var/datum/vampire_clan/clan = get_vampire_clan(clan_type)
	if(!clan)
		return FALSE
	if(clan.accessories)
		return TRUE


/*
/datum/preference/choiced/species_feature/vampire_clan
	abstract_type = /datum/preference/choiced/species_feature/vampire_clan
	var/clans_allowed = list()

/datum/preference/choiced/species_feature/vampire_clan/has_relevant_feature(datum/preferences/preferences)
	var/clan_type = preferences.read_preference(/datum/preference/choiced/vampire_clan)
	var/datum/vampire_clan/clan = get_vampire_clan(clan_type)
	if(clan && (clan.id in clans_allowed))
		return TRUE

/datum/preference/choiced/species_feature/vampire_clan/gangrel_legs
	savefile_key = "feature_gangrel_legs"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	main_feature_name = "Legs"
	clans_allowed = list(VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL)
	relevant_body_markings = /datum/bodypart_overlay/simple/body_marking/gangrel_legs

/datum/bodypart_overlay/simple/body_marking/gangrel_legs
	dna_feature_key = FEATURE_GANGREL_LEGS
	layers = EXTERNAL_ADJACENT

/datum/sprite_accessory/gangrel_legs
	icon = 'modular_darkpack/modules/kindred_species/icons/features.dmi'

/datum/sprite_accessory/gangrel_legs/just_legs
	name = "Legs"
	icon_state = "beast_legs"

/datum/sprite_accessory/gangrel_legs/tail
	name = "Tail"
	icon_state = "beast_tail"

/datum/sprite_accessory/gangrel_legs/both
	name = "Tail and Legs"
	icon_state = "beast_tail_and_legs"

/datum/dna_block/feature/accessory/gangrel_legs
	feature_key = FEATURE_GANGREL_LEGS
*/
