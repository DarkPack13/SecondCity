/datum/quirk/darkpack/organovore
	name = "Conspicuous Consumption"
	desc = "Blood can not sustain you. You can only regain blood points by devouring human flesh and organs. Nagaraja cannot take this trait, as they are already organovores."
	value = -5
	mob_trait = TRAIT_ORGANOVORE
	gain_text = span_notice("You feel an insatiable taste for flesh.")
	lose_text = span_notice("You feel that you can once again feed normally.")
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_NAGARAJA)
	icon = FA_ICON_TEETH
	failure_message = "You feel that you can once again feed normally."

/datum/quirk/darkpack/organovore/add(client/client_source)
	ADD_TRAIT(quirk_holder, TRAIT_CONSPICUOUS_CONSUMPTION, QUIRK_TRAIT)

/datum/quirk/darkpack/organovore/remove()
	REMOVE_TRAIT(quirk_holder, TRAIT_CONSPICUOUS_CONSUMPTION, QUIRK_TRAIT)
