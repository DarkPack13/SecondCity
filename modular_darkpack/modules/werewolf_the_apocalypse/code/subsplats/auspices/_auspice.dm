

/datum/subsplat/werewolf/auspice
	abstract_type = /datum/subsplat/werewolf/auspice

	var/start_rage

	var/moons_born_under = list()

/datum/subsplat/werewolf/auspice/on_gain(datum/splat/gaining, joining_round)
	. = ..()
	if(istype(gaining, /datum/splat/werewolf))
		var/datum/splat/werewolf/werewolf_splat = gaining
		werewolf_splat.adjust_rage(start_rage)

/datum/subsplat/werewolf/auspice/proc/rank_requirments(list/renown)
	return 0

/**
 * Gets the singleton of an Auspice
 * from its name, typepath, or returns the
 * argument if given a Auspice singleton.
 *
 * Arguments:
 * * auspice_identifier - Name, typepath, or singleton of the Auspice being retrieved
 */
/proc/get_fera_auspice(auspice_identifier)
	RETURN_TYPE(/datum/subsplat/werewolf/auspice)

	if (ispath(auspice_identifier))
		return GLOB.auspices[auspice_identifier]
	else if (istext(auspice_identifier))
		return GLOB.auspices[GLOB.auspices_list[auspice_identifier]]
	else
		return auspice_identifier

/**
 * Gives the human a Auspice, applying
 * on_gain effects and post_gain effects if the
 * parameter is true. Can also remove Auspices
 * with or without a replacement, and apply
 * on_lose effects. Will have no effect the human
 * is being given the Auspice it already has.
 *
 * Arguments:
 * * setting_auspice - Typepath or Auspice singleton to give to the human
 * * joining_round - If this Auspice is being given at roundstart and should call on_join_round
 */
/mob/living/carbon/human/proc/set_auspice(setting_auspice, joining_round)
	var/datum/subsplat/werewolf/auspice/previous_auspice = get_our_auspice()

	// Convert IDs and typepaths to singletons, or just directly assign if already singleton
	var/datum/subsplat/werewolf/auspice/new_auspice = get_fera_auspice(setting_auspice)

	// Handle losing Auspice
	previous_auspice?.on_lose(src)

	var/datum/splat/werewolf/shifter/shifter = isshifter(src)
	if (!shifter)
		return

	shifter.auspice = new_auspice

	// Auspice's been cleared, don't apply effects
	if (!new_auspice)
		return

	// Gaining Auspice effects
	new_auspice.on_gain(shifter, joining_round)

/mob/living/proc/get_our_auspice()
	RETURN_TYPE(/datum/subsplat/werewolf/auspice)

	return isshifter(src)?.auspice

/mob/living/proc/is_auspice(auspice_type)
	return istype(get_our_auspice(), auspice_type)
