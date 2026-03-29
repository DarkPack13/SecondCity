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

/datum/quirk/darkpack/territorial/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	var/list/territory_choices = list(
		"Financial District" = /area/vtm/outside/financialdistrict,
		"Ghetto" = /area/vtm/outside/ghetto,
		"Pacific Heights" = /area/vtm/outside/pacificheights,
		"Chinatown" = /area/vtm/outside/chinatown,
		"Fisherman's Wharf" = /area/vtm/outside/fishermanswharf,
		"North Beach" = /area/vtm/outside/northbeach,
		"Union Square" = /area/vtm/outside/unionsquare,
		"Park" = /area/vtm/outside/park,
		"Forest" = /area/vtm/outside/forest,
	)

	var/choice = tgui_input_list(
		new_holder,
		"Select your territory. This is the only place you may feed.",
		"Territorial Boundry",
		territory_choices
	)

	territory = territory_choices[choice]
