/**
 * # SubSplat
 *
 * Represents the "splats" described in splatbooks, e.g clanbooks and tribebooks.
 */
/datum/subsplat
	abstract_type = /datum/subsplat

	/// Name of the splat
	var/name
	/// Description of what the splat is and what it does
	var/desc
	/// ID for trait sources and whatnot
	var/id

/datum/subsplat/proc/on_gain()
	return

/datum/subsplat/proc/on_lose()
	return

/proc/init_subsplat_list(path = /datum/subsplat)
	var/list/subsplat_list = list()
	for (var/datum/subsplat/subsplat as anything in valid_subtypesof(path))
		subsplat_list[subsplat::name] = subsplat
	subsplat_list = sort_list(subsplat_list)
	return subsplat_list
