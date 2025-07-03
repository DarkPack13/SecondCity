/// Associative list of Clan names to typepaths
GLOBAL_LIST_INIT(vampire_clan_list, init_vampire_clan_list())

/proc/init_vampire_clan_list()
	var/list/clan_list = list()
	for (var/datum/vampire_clan/clan_type as anything in subtypesof(/datum/vampire_clan))
		clan_list[initial(clan_type.name)] = clan_type
	return clan_list

/// Associative list of Clan typepaths to singletons
GLOBAL_LIST_INIT_TYPED(vampire_clans, /datum/vampire_clan, init_vampire_clans())

/proc/init_vampire_clans()
	var/list/clan_list = list()
	for (var/datum/vampire_clan/clan_type as anything in subtypesof(/datum/vampire_clan))
		clan_list[clan_type] = new clan_type
	return clan_list

/// All frenzied players
GLOBAL_LIST_EMPTY(frenzy_list)
