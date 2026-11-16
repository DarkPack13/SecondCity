GLOBAL_LIST_INIT(fetish_merit_choice, generate_merit_artifact_choices(/obj/item/occult_artifact/werewolf))
GLOBAL_LIST_INIT(vampire_artifact_merit_choice, generate_merit_artifact_choices(/obj/item/occult_artifact/vampire))

/proc/generate_merit_artifact_choices(valid_type)
	var/list/choices = list()
	for(var/obj/item/occult_artifact/werewolf/fetish as anything in valid_subtypesof(valid_type))
		if(fetish::rank != 1)
			continue
		choices[fetish::true_name] = fetish
	return choices

/datum/quirk/darkpack/item_quirk/occult_artifact
	abstract_type = /datum/quirk/darkpack/item_quirk/occult_artifact
	icon = FA_ICON_MAGIC
	var/obj/item/default_artifact
	var/linked_pref

/datum/quirk/darkpack/item_quirk/occult_artifact/proc/artifact_choices()

/datum/quirk/darkpack/item_quirk/occult_artifact/add_unique(client/client_source)
	var/mob/living/carbon/human/fetish_owner = astype(quirk_holder)
	if(!fetish_owner)
		return

	var/list/choices = artifact_choices()

	var/fetish_type = choices[client_source?.prefs?.read_preference(linked_pref)] || default_artifact
	if(isnull(fetish_type))
		fetish_type = choices[pick(choices)]
	var/obj/item/occult_artifact/new_heirloom = new fetish_type(get_turf(fetish_owner))

	give_item_to_holder(
		new_heirloom,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "This is your precious fetish!",
		notify_player = TRUE,
	)

	new_heirloom.identify(fetish_owner)

/datum/quirk/darkpack/item_quirk/occult_artifact/fetish
	name = "Fetish"
	desc = "You own a weak fetish. You may have inherited this item, received it as a gift, it should have an important value to you."
	value = 3 // Middle ground price between the kinfolk merit or garou background
	// Acctually a kinfolk merit in the books.
	allowed_splats = list(SPLAT_KINFOLK, SPLAT_GAROU, SPLAT_CORAX)

	ttrpg_sources = list(
		/datum/source_book/wta20 = 137, // for the kinfolk fetish
		/datum/source_book/wta20 = 383, // for the garou background rather then the kinfolk merit.
	)

	default_artifact = /obj/item/occult_artifact/werewolf/nyxs_bangle
	linked_pref = /datum/preference/choiced/fetish_merit

/datum/quirk/darkpack/item_quirk/occult_artifact/fetish/artifact_choices()
	return GLOB.fetish_merit_choice


/datum/quirk/darkpack/item_quirk/occult_artifact/vampire
	name = "Artifact"
	desc = "You own a weak kindred artifact. You may have inherited this item, received it as a gift, it should have an important value to you."
	value = 3
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL)

/datum/quirk/darkpack/item_quirk/occult_artifact/vampire/artifact_choices()
	return GLOB.vampire_artifact_merit_choice


/datum/quirk_constant_data/fetish_choice
	associated_typepath = /datum/quirk/darkpack/item_quirk/occult_artifact/fetish
	customization_options = list(/datum/preference/choiced/fetish_merit)


/datum/quirk_constant_data/vampire_artifact_choice
	associated_typepath = /datum/quirk/darkpack/item_quirk/occult_artifact/vampire
	customization_options = list(/datum/preference/choiced/vampire_artifact_merit)


/datum/preference/choiced/fetish_merit
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "fetish_merit"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/fetish_merit/init_possible_values()
	return list("Random") + GLOB.fetish_merit_choice

/datum/preference/choiced/fetish_merit/create_default_value()
	return "Random"

/datum/preference/choiced/fetish_merit/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE
	return /datum/quirk/darkpack/item_quirk/occult_artifact/fetish::name in preferences.all_quirks

/datum/preference/choiced/fetish_merit/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return


/datum/preference/choiced/vampire_artifact_merit
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "vampire_artifact_merit"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/vampire_artifact_merit/init_possible_values()
	return list("Random") + GLOB.vampire_artifact_merit_choice

/datum/preference/choiced/vampire_artifact_merit/create_default_value()
	return "Random"

/datum/preference/choiced/vampire_artifact_merit/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE
	return /datum/quirk/darkpack/item_quirk/occult_artifact/vampire::name in preferences.all_quirks

/datum/preference/choiced/vampire_artifact_merit/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return
