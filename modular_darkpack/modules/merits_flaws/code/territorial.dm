/datum/quirk/darkpack/territorial
	name = "Territorial"
	desc = "You are extremely territorial, and can only feed in one particular area. You react with hostility if another vampire enters your territory without your notice - and if they feed without your permission, violence is sure to break out, as they're taking your food and resources. You are reluctant to leave your territory unless necessary. When joining the game, youll be prompted to select your territory - the only area where you may feed."
	value = -2
	mob_trait = TRAIT_VAMPIRE_TERRITORIAL
	gain_text = span_notice("You need to protect your hunting grounds, your herd, your territory.")
	lose_text = span_notice("Who cares where anyone feeds, anyways?")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_MAP_LOCATION_DOT
	failure_message = "Who cares where anyone feeds, anyways?"
	var/area/vtm/territory

/datum/quirk_constant_data/territorial
	associated_typepath = /datum/quirk/darkpack/territorial
	customization_options = list(/datum/preference/choiced/territorial)

/datum/quirk/darkpack/territorial/add(client/client_source)
	var/list/territory_choices = list(
		/area/vtm/outside/financialdistrict::name = /area/vtm/outside/financialdistrict,
		/area/vtm/outside/ghetto::name = /area/vtm/outside/ghetto,
		/area/vtm/outside/pacificheights::name = /area/vtm/outside/pacificheights,
		/area/vtm/outside/chinatown::name = /area/vtm/outside/chinatown,
		/area/vtm/outside/fishermanswharf::name = /area/vtm/outside/fishermanswharf,
		/area/vtm/outside/northbeach::name = /area/vtm/outside/northbeach,
		/area/vtm/outside/baywalk::name = /area/vtm/outside/baywalk,
		/area/vtm/outside/unionsquare::name = /area/vtm/outside/unionsquare,
		/area/vtm/outside/park::name = /area/vtm/outside/park,
		/area/vtm/outside/forest::name = /area/vtm/outside/forest,
		/area/vtm/outside/supply::name = /area/vtm/outside/supply,
		/area/vtm/interior/anarch::name = /area/vtm/interior/anarch,
		/area/vtm/interior/sewer::name = /area/vtm/interior/sewer,
		/area/vtm/interior/sewer/nosferatu_town::name = /area/vtm/interior/sewer/nosferatu_town,
		/area/vtm/interior/library::name = /area/vtm/interior/library,
		/area/vtm/interior/chantry::name = /area/vtm/interior/chantry/basement,
		/area/vtm/interior/caves::name = /area/vtm/interior/caves,
		/area/vtm/interior/giovanni::name = /area/vtm/interior/giovanni,
		/area/vtm/interior/giovanni::name = /area/vtm/interior/giovanni,
		/area/vtm/interior/millennium_tower::name = /area/vtm/interior/millennium_tower,
		/area/vtm/interior/strip::name = /area/vtm/interior/strip,
		/area/vtm/interior/jazzclub::name = /area/vtm/interior/jazzclub,
		/area/vtm/interior/clinic::name = /area/vtm/interior/clinic,
		/area/vtm/interior/apartment::name = /area/vtm/interior/apartment,
		/area/vtm/interior/bianchiBank::name = /area/vtm/interior/bianchiBank,
		/area/vtm/interior/museum::name = /area/vtm/interior/museum,
		/area/vtm/interior/apartment::name = /area/vtm/interior/apartment,
		/area/vtm/interior/bianchiBank::name = /area/vtm/interior/bianchiBank,
		"Sabbat Lair" = /area/vtm/interior/sabbat_lair, // it's called 'interior' on name, people would use bloodhunt skull and see 'sabbat lair' and run straight there.
		/area/vtm/interior/littleitaly::name = /area/vtm/interior/littleitaly,
		/area/vtm/interior/police::name = /area/vtm/interior/police,
	)

	var/chosen_name = client_source?.prefs.read_preference(/datum/preference/choiced/territorial) || /area/vtm/outside/financialdistrict::name
	territory = territory_choices[chosen_name]
