// VTM pg. 482
/datum/quirk/darkpack/open_wound
	name = "Open Wound"
	desc = {"You have one or more wounds that refuse to heal, and which constantly drip blood.
This slow leakage costs you an extra blood point per evening,
in addition to drawing attention to you.
If the wound is visible, you are at + 1 difficulty for all Social-based rolls."}
	value = -2 // If we decide to use the 4 point flaw version, make incompatible with permanent wound.
	gain_text = span_notice("An unhealed wound bleeds.")
	lose_text = span_notice("Old wounds heal.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_BANDAGE
	failure_message = "Old wounds heal."
	var/wound_location

/*You have one or more wounds that refuse to heal,
and which constantly drip blood. This slow leakage
costs you an extra blood point per evening (marked off
just before dawn), in addition to drawing attention to
you. If the wound is visible, you are at + 1 difficulty for
all Social-based rolls. For two points, the Flaw is simply
unsightly and has the basic effect mentioned above; for
four points the seeping wound is serious or disfiguring
and includes the effects of the Flaw Permanent Wound
(below).*/


/datum/quirk_constant_data/open_wound
	associated_typepath = /datum/quirk/darkpack/open_wound
	customization_options = list(/datum/preference/choiced/wound_location)

/datum/preference/choiced/wound_location
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "wound_location"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/wound_location/init_possible_values()
	return list("face", "chest") // I'm tired, so just two options for now.

/datum/preference/choiced/wound_location/create_default_value()
	return "face"

/datum/preference/choiced/wound_location/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return /datum/quirk/darkpack/open_wound::name in preferences.all_quirks

/datum/preference/choiced/wound_location/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/quirk/darkpack/open_wound/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	wound_location = client_source?.prefs.read_preference(/datum/preference/choiced/wound_location)
	var/mob/living/carbon/human/human_holder = new_holder
	human_holder.bloodpool -= 1 // Take 1 BP away.
	switch(wound_location) // Better cover up.
		if("face")
			ADD_TRAIT(quirk_holder, TRAIT_OPEN_WOUND_FACE, QUIRK_TRAIT)
		if("chest")
			ADD_TRAIT(quirk_holder, TRAIT_OPEN_WOUND_CHEST, QUIRK_TRAIT)

/datum/quirk/darkpack/open_wound/remove(client/client_source)
	. = ..()
	wound_location = client_source?.prefs.read_preference(/datum/preference/choiced/wound_location)
	switch(wound_location)
		if("face")
			REMOVE_TRAIT(quirk_holder, TRAIT_OPEN_WOUND_FACE, QUIRK_TRAIT)
		if("chest")
			REMOVE_TRAIT(quirk_holder, TRAIT_OPEN_WOUND_CHEST, QUIRK_TRAIT)

