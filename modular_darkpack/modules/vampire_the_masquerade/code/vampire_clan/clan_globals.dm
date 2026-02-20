/// Associative list of Clan names to typepaths
GLOBAL_LIST_INIT(vampire_clan_list, init_vampire_clan_list())

/proc/init_vampire_clan_list()
	var/list/clan_list = list()
	for (var/datum/vampire_clan/clan_type as anything in valid_subtypesof(/datum/vampire_clan))
		clan_list[clan_type::name] = clan_type
	clan_list = sort_list(clan_list)
	return clan_list

/// Associative list of Clan typepaths to singletons
GLOBAL_LIST_INIT_TYPED(vampire_clans, /datum/vampire_clan, init_subtypes_w_path_keys(/datum/vampire_clan, list()))

/// All frenzied players
GLOBAL_LIST_EMPTY(frenzy_list)
