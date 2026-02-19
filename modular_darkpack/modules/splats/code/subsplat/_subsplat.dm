// DARKPACK TODO - This should include clans.

/**
 * # Subsplat
 *
 * Represents the "splats" described in splatbooks, e.g. clans, tribes, factions and kiths.
 * These are the "real" splats but we call them subsplats as we used that type path for what WW calls supernaturals
 * A more official term sometimes used, especially for games in the Chronicles of Darkness, is "character axis".
 *
 * These at present are only stored on splats as a var for a given subtype and requires mostly implementing its own handling for everything.
 */
/datum/subsplat
	abstract_type = /datum/subsplat

	/// Name of the splat
	var/name
	/// Description of what the splat is and what it does
	var/desc
	/// ID for trait sources and whatnot
	var/id

/datum/subsplat/proc/on_gain(datum/splat/gaining, joining_round)
	SHOULD_CALL_PARENT(TRUE)
	return

/datum/subsplat/proc/on_lose()
	SHOULD_CALL_PARENT(TRUE)
	return
