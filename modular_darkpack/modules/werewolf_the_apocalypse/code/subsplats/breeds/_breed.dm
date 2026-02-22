// Not a splat in the TTRPG but functions like one in terms of code.
/datum/subsplat/werewolf/breed_form
	abstract_type = /datum/subsplat/werewolf/breed_form

	var/start_gnosis

	var/breed_species

/datum/subsplat/werewolf/breed_form/on_gain(datum/splat/gaining, joining_round)
	. = ..()
	if(istype(gaining, /datum/splat/werewolf))
		var/datum/splat/werewolf/werewolf_splat = gaining
		werewolf_splat.adjust_gnosis(start_gnosis)

/**
 * Gets the singleton of an breed_form
 * from its name, typepath, or returns the
 * argument if given a breed_form singleton.
 *
 * Arguments:
 * * breed_form_identifier - Name, typepath, or singleton of the breed_form being retrieved
 */
/proc/get_fera_breed_form(breed_form_identifier)
	RETURN_TYPE(/datum/subsplat/werewolf/breed_form)

	if (ispath(breed_form_identifier))
		return GLOB.breed_forms[breed_form_identifier]
	else if (istext(breed_form_identifier))
		return GLOB.breed_forms[GLOB.breed_forms_list[breed_form_identifier]]
	else
		return breed_form_identifier

/**
 * Gives the human a breed_form, applying
 * on_gain effects and post_gain effects if the
 * parameter is true. Can also remove breed_forms
 * with or without a replacement, and apply
 * on_lose effects. Will have no effect the human
 * is being given the breed_form it already has.
 *
 * Arguments:
 * * setting_breed_form - Typepath or breed_form singleton to give to the human
 * * joining_round - If this breed_form is being given at roundstart and should call on_join_round
 */
/mob/living/carbon/human/proc/set_breed_form(setting_breed_form, joining_round)
	var/datum/subsplat/werewolf/breed_form/previous_breed_form = get_our_breed_form()

	// Convert IDs and typepaths to singletons, or just directly assign if already singleton
	var/datum/subsplat/werewolf/breed_form/new_breed_form = get_fera_breed_form(setting_breed_form)

	// Handle losing breed_form
	previous_breed_form?.on_lose(src)

	var/datum/splat/werewolf/shifter/shifter = isshifter(src)
	if (!shifter)
		return

	shifter.breed_form = new_breed_form

	// breed_form's been cleared, don't apply effects
	if (!new_breed_form)
		return

	// Gaining breed_form effects
	new_breed_form.on_gain(shifter, joining_round)

/mob/living/proc/get_our_breed_form()
	RETURN_TYPE(/datum/subsplat/werewolf/breed_form)

	return isshifter(src)?.breed_form

/mob/living/proc/is_breed_form(breed_form_type)
	return istype(get_our_breed_form(), breed_form_type)
