GLOBAL_LIST_INIT(prey_exclusion_choice, list(
	"Middle-income",
	"Police Officers",
	"Criminals",
	"High income",
	//"Strippers",
	"Homeless"
))

/datum/quirk/darkpack/prey_exclusion
	name = "Prey Exclusion"
	desc = "You refuse to hunt a certain kind of prey. When joining the game, you'll have to select what type of NPC you cant feed from. Ventrue cannot take this flaw."
	value = -1
	mob_trait = TRAIT_PREY_EXCLUSION
	gain_text = span_notice("You feel very picky about what type of person you feed from.")
	lose_text = span_notice("You don't care about who you feed from anymore.")
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_VENTRUE)
	icon = FA_ICON_FACE_FROWN
	failure_message = "You don't care about who you feed from anymore."
	/// which type of prey the user selected
	var/prey_exclusion

/datum/quirk_constant_data/prey_exclusion
	associated_typepath = /datum/quirk/darkpack/prey_exclusion
	customization_options = list(/datum/preference/choiced/prey_exclusion)

/datum/quirk/darkpack/prey_exclusion/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	// alot of these npcs, like 'bacotell' 'bubway' and 'endronsecurity_2' should probably not be available to be taken since they're so specialized.
	var/list/list_of_available_npcs = list(
		"Middle-income" = /mob/living/carbon/human/npc/incel, // the social role assigned is 'usual male'...
		"Police Officers" = /mob/living/carbon/human/npc/police,
		"Criminals" = /mob/living/carbon/human/npc/bandit,
		"High income" = /mob/living/carbon/human/npc/business,
		//"Strippers" = /mob/living/carbon/human/npc/stripper, i feel like this would be the most powergamed option. keeping it here but commented.
		"Homeless" = /mob/living/carbon/human/npc/hobo)
	var/prey_exclusion_choice = tgui_input_list(new_holder, "Which type of prey are you disgusted by?", "Prey Exclusion", list_of_available_npcs)
	prey_exclusion = list_of_available_npcs[prey_exclusion_choice]


/datum/preference/choiced/prey_exclusion
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "prey_exclusion"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/prey_exclusion/init_possible_values()
	return GLOB.prey_exclusion_choice

/datum/preference/choiced/prey_exclusion/create_default_value()
	return "Homeless"

/datum/preference/choiced/prey_exclusion/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return /datum/quirk/darkpack/territorial::name in preferences.all_quirks

/datum/preference/choiced/prey_exclusion/apply_to_human(mob/living/carbon/human/target, value)
	return
