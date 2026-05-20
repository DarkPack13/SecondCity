/datum/quirk/darkpack/stigmata_of_the_wyrm
	name = "Stigmata of the Wyrm"
	desc = {"You have undergone some immense test or trial after total and complete devotion to the Wyrm,
		leaving you with some kind of bodily mark that is known to other servants of the Wyrm."}
	value = 4
	mob_trait = TRAIT_FOMORI_STIGMATA
	gain_text = span_notice("You feel respected by servants of the Wyrm.")
	lose_text = span_notice("You feel forsaken by servants of the Wyrm.")
	icon = FA_ICON_STRIKETHROUGH
	allowed_splats = list(SPLAT_FOMORI)
	failure_message =  "You feel forsaken by servants of the Wyrm."
	var/stigmata // String which effects examine text
	var/examine_print

/datum/quirk/darkpack/stigmata_of_the_wyrm/add(client/client_source)
	// add runs before add_unique so we rely on it to decide
	if(!stigmata)
		stigmata = client_source?.prefs.read_preference(/datum/preference/choiced/stigmata_of_the_wyrm)

/datum/quirk/darkpack/stigmata_of_the_wyrm/add_unique(client/client_source)
	switch(stigmata)
		if("scars on palms")
			examine_print = "scars on the center of [p_their()] palms"
		if("forked tongue")
			examine_print = "a forked tongue"
		if("hypnotic tattoos")
			examine_print = "tattoos that make your head spin"
		if("always-open eyes")
			examine_print = "eyes that haven't blinked since you've been looking"
		if("brand burns")
			examine_print = "burns like that of a cattle brand"

/datum/quirk_constant_data/stigmata_of_the_wyrm_choice
	associated_typepath = /datum/quirk/darkpack/stigmata_of_the_wyrm
	customization_options = list(/datum/preference/choiced/stigmata_of_the_wyrm)

/datum/preference/choiced/stigmata_of_the_wyrm
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "stigmata_of_the_wyrm"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/stigmata_of_the_wyrm/init_possible_values()
	return list("scars on palms", "forked tongue", "hypnotic tattoos", "always-open eyes", "brand burns")

/datum/preference/choiced/stigmata_of_the_wyrm/create_default_value()
	return "scars on palms"

/datum/preference/choiced/stigmata_of_the_wyrm/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return /datum/quirk/darkpack/stigmata_of_the_wyrm::name in preferences.all_quirks

/datum/preference/choiced/stigmata_of_the_wyrm/apply_to_human(mob/living/carbon/human/target, value)
	return
