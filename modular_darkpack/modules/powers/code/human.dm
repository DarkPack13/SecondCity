/datum/species/human
	var/list/disciplines

/**
 * Accesses a certain Discipline that a person has. Null if not found.
 * Human species since ghouls and kindred aren't subtypes of eachother.
 *
 * Arguments:
 * * searched_discipline - Name or typepath of the Discipline being searched for.
 */
/datum/species/human/proc/get_discipline(searched_discipline)
	for (var/datum/discipline/discipline in disciplines)
		if (istype(discipline, searched_discipline))
			return discipline
