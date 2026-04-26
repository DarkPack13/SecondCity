// VTM pg. 479-480
/datum/quirk/darkpack/acute_sense
	name = "Acute Sense"
	desc = {"One of your senses is exceptionally sharp, be it sight, hearing, smell, touch, or taste.
The difficulties for all tasks involving the use of this particular sense are reduced by two."} // Find what checks need to be changed here.
	value = 1
	icon = FA_ICON_EYE
	var/sense

/*One of your senses is exceptionally sharp, be it sight,
hearing, smell, touch, or taste. The difficulties for all
tasks involving the use of this particular sense are re
duced by two. This Merit can be combined with the
Discipline of Auspex to produce superhuman sensory
acuity.*/

/datum/quirk_constant_data/acute_sense
	associated_typepath = /datum/quirk/darkpack/acute_sense
	customization_options = list(/datum/preference/choiced/acute_sense)

/datum/preference/choiced/acute_sense
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "acute_sense"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/acute_sense/init_possible_values()
	return list("hearing", "smell", "sight", "taste", "touch")

/datum/preference/choiced/acute_sense/create_default_value()
	return "hearing"

/datum/preference/choiced/acute_sense/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return /datum/quirk/darkpack/acute_sense::name in preferences.all_quirks

/datum/preference/choiced/acute_sense/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/quirk/darkpack/acute_sense/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	sense = client_source?.prefs.read_preference(/datum/preference/choiced/acute_sense)
	switch(sense)
		if("hearing")// Debating checking for flaws to invalidate this, but they won't be able to use the merit while deaf anyways
			ADD_TRAIT(new_holder, TRAIT_ACUTE_HEARING, QUIRK_TRAIT) // Used to hear more.
			var/obj/item/organ/ears/sensitive_ears = quirk_holder.get_organ_slot(ORGAN_SLOT_EARS)
			sensitive_ears.damage_multiplier = sensitive_ears.damage_multiplier + 1 // We hear better, and there are consequences.
		if("smell") // Debate adding a check for TRAIT_ANOSMIA, but we don't currently have it selectable
			ADD_TRAIT(new_holder, TRAIT_KEEN_NOSE, QUIRK_TRAIT)
		if("sight") // Debate adding a check, but like hearing, you can't use the benefits while blind really
			ADD_TRAIT(new_holder, TRAIT_ACUTE_SIGHT, QUIRK_TRAIT)
			quirk_holder.client?.view_size?.setTo(1)
			var/obj/item/organ/eyes/sensitive_eyes = quirk_holder.get_organ_slot(ORGAN_SLOT_EYES)
			if(sensitive_eyes)
				sensitive_eyes.flash_protect = max(sensitive_eyes.flash_protect += -1, FLASH_PROTECTION_SENSITIVE)
		if("taste")
			ADD_TRAIT(new_holder, TRAIT_DETECTIVES_TASTE, QUIRK_TRAIT)
		if("touch")
			ADD_TRAIT(new_holder, TRAIT_SELF_AWARE, QUIRK_TRAIT) // Does this seem fitting? It shouldn't be as strong as auspex is.

/datum/quirk/darkpack/acute_sense/remove(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	switch(sense)
		if("hearing")
			REMOVE_TRAIT(quirk_holder, TRAIT_ACUTE_HEARING, QUIRK_TRAIT)
			var/obj/item/organ/ears/sensitive_ears = quirk_holder.get_organ_slot(ORGAN_SLOT_EARS)
			sensitive_ears.damage_multiplier = sensitive_ears.damage_multiplier - 1
		if("smell")
			REMOVE_TRAIT(new_holder, TRAIT_KEEN_NOSE, QUIRK_TRAIT)
		if("sight")
			REMOVE_TRAIT(new_holder, TRAIT_ACUTE_SIGHT, QUIRK_TRAIT)
			quirk_holder.client?.view_size?.resetToDefault() // Check this doesn't fuck auspex up, but it should be fine.
			var/obj/item/organ/eyes/sensitive_eyes = quirk_holder.get_organ_slot(ORGAN_SLOT_EYES)
			if(sensitive_eyes)
				sensitive_eyes.flash_protect = max(sensitive_eyes.flash_protect += 1, FLASH_PROTECTION_NONE)
		if("taste")
			REMOVE_TRAIT(new_holder, TRAIT_DETECTIVES_TASTE, QUIRK_TRAIT)
		if("touch")
			REMOVE_TRAIT(new_holder, TRAIT_SELF_AWARE, QUIRK_TRAIT)
