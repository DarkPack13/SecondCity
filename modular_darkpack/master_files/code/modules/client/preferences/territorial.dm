GLOBAL_LIST_INIT(territorial_choice, list(
	/area/vtm/outside/financialdistrict::name,
	/area/vtm/outside/ghetto::name,
	/area/vtm/outside/pacificheights::name,
	/area/vtm/outside/chinatown::name,
	/area/vtm/outside/fishermanswharf::name,
	/area/vtm/outside/northbeach::name,
	/area/vtm/outside/baywalk::name,
	/area/vtm/outside/unionsquare::name,
	/area/vtm/outside/park::name,
	/area/vtm/outside/forest::name,
	/area/vtm/outside/supply::name,
	/area/vtm/interior/anarch::name,
	/area/vtm/interior/sewer::name,
	/area/vtm/interior/sewer/nosferatu_town::name,
	/area/vtm/interior/library::name,
	/area/vtm/interior/chantry::name,
	/area/vtm/interior/caves::name,
	/area/vtm/interior/mansion::name,
	/area/vtm/interior/giovanni::name,
	/area/vtm/interior/millennium_tower::name,
	/area/vtm/interior/strip::name,
	/area/vtm/interior/jazzclub::name,
	/area/vtm/interior/clinic::name,
	/area/vtm/interior/museum::name,
	/area/vtm/interior/apartment::name,
	/area/vtm/interior/bianchiBank::name,
	"Sabbat Lair",
	/area/vtm/interior/littleitaly::name,
	/area/vtm/interior/police::name,

))

/datum/preference/choiced/territorial
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "territorial"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/territorial/init_possible_values()
	return GLOB.territorial_choice

/datum/preference/choiced/territorial/create_default_value()
	return /area/vtm/outside/financialdistrict::name

/datum/preference/choiced/territorial/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Territorial" in preferences.all_quirks

/datum/preference/choiced/territorial/apply_to_human(mob/living/carbon/human/target, value)
	return
