/datum/subsplat/werewolf/tribe
	abstract_type = /datum/subsplat/werewolf/tribe

	var/tribe_keys
	//var/tribe_trait

/**
 * Gets the singleton of an tribe
 * from its name, typepath, or returns the
 * argument if given a tribe singleton.
 *
 * Arguments:
 * * tribe_identifier - Name, typepath, or singleton of the tribe being retrieved
 */
/proc/get_fera_tribe(tribe_identifier)
	RETURN_TYPE(/datum/subsplat/werewolf/tribe)

	if (ispath(tribe_identifier))
		return GLOB.fera_tribes[tribe_identifier]
	else if (istext(tribe_identifier))
		return GLOB.fera_tribes[GLOB.tribes_list[tribe_identifier]]
	else
		return tribe_identifier

/**
 * Gives the human a tribe, applying
 * on_gain effects and post_gain effects if the
 * parameter is true. Can also remove tribes
 * with or without a replacement, and apply
 * on_lose effects. Will have no effect the human
 * is being given the tribe it already has.
 *
 * Arguments:
 * * setting_tribe - Typepath or tribe singleton to give to the human
 * * joining_round - If this tribe is being given at roundstart and should call on_join_round
 */
/mob/living/carbon/human/proc/set_fera_tribe(setting_tribe, joining_round)
	var/datum/subsplat/werewolf/tribe/previous_tribe = get_our_tribe()

	// Convert IDs and typepaths to singletons, or just directly assign if already singleton
	var/datum/subsplat/werewolf/tribe/new_tribe = get_fera_tribe(setting_tribe)

	// Handle losing tribe
	previous_tribe?.on_lose(src)

	var/datum/splat/werewolf/shifter/shifter = isshifter(src)
	if (!shifter)
		return

	shifter.tribe = new_tribe

	// tribe's been cleared, don't apply effects
	if (!new_tribe)
		return

	// Gaining tribe effects
	new_tribe.on_gain(shifter, joining_round)

/mob/living/proc/get_our_tribe()
	RETURN_TYPE(/datum/subsplat/werewolf/tribe)

	return isshifter(src)?.tribe

/mob/living/proc/is_tribe(tribe_type)
	return istype(get_our_tribe(), tribe_type)
