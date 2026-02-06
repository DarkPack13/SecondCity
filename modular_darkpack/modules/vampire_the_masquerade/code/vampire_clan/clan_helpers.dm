/**
 * Gets the singleton of a vampiric Clan
 * from its name, typepath, or returns the
 * argument if given a Clan singleton.
 *
 * Arguments:
 * * clan_identifier - Name, typepath, or singleton of the Clan being retrieved
 */
/proc/get_vampire_clan(clan_identifier)
	RETURN_TYPE(/datum/vampire_clan)

	if (ispath(clan_identifier))
		return GLOB.vampire_clans[clan_identifier]
	else if (istext(clan_identifier))
		return GLOB.vampire_clans[GLOB.vampire_clan_list[clan_identifier]]
	else
		return clan_identifier
