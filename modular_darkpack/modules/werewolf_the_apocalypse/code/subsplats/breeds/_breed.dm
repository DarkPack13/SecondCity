// Not a splat in the TTRPG but functions like one in terms of code.
/datum/subsplat/werewolf/breed_form
	abstract_type = /datum/subsplat/werewolf/breed_form

	var/start_gnosis

	var/breed_species

/datum/subsplat/werewolf/breed_form/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	var/datum/splat/werewolf/werewolf_splat = astype(gaining_splat)
	werewolf_splat?.adjust_gnosis(start_gnosis)

/datum/subsplat/werewolf/breed_form/proc/generation_pref_icon(datum/universal_icon/main_icon)
	var/datum/universal_icon/breed_homid = uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_head_m")
	breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_chest_m"), ICON_OVERLAY)
	breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_arm"), ICON_OVERLAY)
	breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_arm"), ICON_OVERLAY)
	breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_leg"), ICON_OVERLAY)
	breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_leg"), ICON_OVERLAY)
	breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_hand"), ICON_OVERLAY)
	breed_homid.blend_icon(uni_icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_hand"), ICON_OVERLAY)
	breed_homid.blend_color(skintone2hex("caucasian1"), ICON_MULTIPLY)
	breed_homid.scale(32, 32)
	main_icon.blend_icon(breed_homid, ICON_OVERLAY)


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

	var/datum/splat/werewolf/shifter/shifter = get_shifter_splat(src)
	if (!shifter)
		return

	shifter.breed_form = new_breed_form

	// breed_form's been cleared, don't apply effects
	if (!new_breed_form)
		return

	// Gaining breed_form effects
	new_breed_form.on_gain(src, shifter, joining_round)

/mob/living/proc/get_our_breed_form()
	RETURN_TYPE(/datum/subsplat/werewolf/breed_form)

	return get_shifter_splat(src)?.breed_form

/mob/living/proc/is_breed_form(breed_form_type)
	return istype(get_our_breed_form(), breed_form_type)
