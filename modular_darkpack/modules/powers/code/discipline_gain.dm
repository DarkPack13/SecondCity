/**
 * Initialises Disciplines for new vampire mobs, applying effects and creating action buttons.
 *
 * If discipline_pref is true, it grabs all of the source's Disciplines from their preferences
 * and applies those using the give_discipline() proc. If false, it instead grabs a given list
 * of Discipline typepaths and initialises those for the character. Only works for ghouls and
 * vampires.
 *
 * Arguments:
 * * discipline_pref - Whether Disciplines will be taken from preferences. True by default.
 * * disciplines - list of Discipline typepaths to grant if discipline_pref is false.
 */
/mob/living/carbon/human/proc/create_disciplines(discipline_pref = TRUE, list/disciplines)	//EMBRACE BASIC
	if ((dna.species.id == SPECIES_KINDRED) || (dna.species.id == SPECIES_GHOUL)) //only splats that have Disciplines qualify
		var/list/datum/discipline/adding_disciplines = list()

		// TODO: [Rebase] reimplement Discipline selection?
		/*
		if (discipline_pref) //initialise player's own disciplines
			for (var/i in 1 to client.prefs.discipline_types.len)
				var/type_to_create = client.prefs.discipline_types[i]
				var/level = client.prefs.discipline_levels[i]
				var/datum/discipline/discipline = new type_to_create(level)

				//prevent Disciplines from being used if not whitelisted for them
				if (discipline.clan_restricted)
					if (!can_access_discipline(src, type_to_create))
						qdel(discipline)
						continue

				adding_disciplines += discipline
		else*/ if (disciplines.len) //initialise given disciplines
			for (var/i in 1 to disciplines.len)
				var/type_to_create = disciplines[i]
				var/datum/discipline/discipline = new type_to_create(1)
				adding_disciplines += discipline

		for (var/datum/discipline/discipline in adding_disciplines)
			give_discipline(discipline)

/**
 * Creates an action button and applies post_gain effects of the given Discipline.
 *
 * Arguments:
 * * discipline - Discipline datum that is being given to this mob.
 */
/mob/living/carbon/human/proc/give_discipline(datum/discipline/discipline)
	if (discipline.level > 0)
		var/datum/action/discipline/action = new(discipline)
		action.Grant(src)
	var/datum/species/human/species = dna.species
	LAZYADD(species.disciplines, discipline)

/**
 * Checks a vampire for whitelist access to a Discipline.
 *
 * Checks the given vampire to see if they have access to a certain Discipline through
 * one of their selectable Clans. This is only necessary for "unique" or Clan-restricted
 * Disciplines, as those have a chance to only be available to a certain Clan that
 * the vampire may or may not be whitelisted for.
 *
 * Arguments:
 * * vampire_checking - The vampire mob being checked for their access.
 * * discipline_checking - The Discipline type that access to is being checked.
 */
/proc/can_access_discipline(mob/living/carbon/human/vampire_checking, discipline_checking)
	if (isghoul(vampire_checking))
		return TRUE
	if (!iskindred(vampire_checking))
		return FALSE
	if (!vampire_checking.client)
		return FALSE

	//make sure it's actually restricted and this check is necessary
	var/datum/discipline/discipline_object_checking = new discipline_checking
	if (!discipline_object_checking.clan_restricted)
		qdel(discipline_object_checking)
		return TRUE
	qdel(discipline_object_checking)

	//first, check their Clan Disciplines to see if that gives them access
	if (vampire_checking.clan.clan_disciplines.Find(discipline_checking))
		return TRUE

	//next, go through all Clans to check if they have access to any with the Discipline
	for (var/clan_type in subtypesof(/datum/vampire_clan))
		var/datum/vampire_clan/clan_checking = new clan_type

		//skip this if they can't access it due to whitelists
		// TODO: [Rebase] reimplement whitelisting
		/*
		if (clan_checking.whitelisted)
			if (!SSwhitelists.is_whitelisted(checked_ckey = vampire_checking.ckey, checked_whitelist = clan_checking.name))
				qdel(clan_checking)
				continue
		*/

		if (clan_checking.clan_disciplines.Find(discipline_checking))
			qdel(clan_checking)
			return TRUE

		qdel(clan_checking)

	//nothing found
	return FALSE
