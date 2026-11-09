/datum/quirk/darkpack/primal_perception
	name = "Primal Perception"
	desc = {"The time spent around your shifting kin has not gone without merit.
			Though impossible to properly speak, you can fluently discern their
			Primal Tongue."}
	ttrpg_sources = list(/datum/source_book/homebrew = WE_MADE_IT_UP)
	value = 1
	mob_trait = TRAIT_PRIMAL_PERCEPTION
	gain_text = span_notice("The language of beasts is clearer than day to your ears.")
	lose_text = span_notice("The sounds of beasts are no longer discernable to you.")
	icon = FA_ICON_EAR_LISTEN
	failure_message = "The sounds of beasts are no longer discernable to you."
	allowed_splats = list(SPLAT_KINFOLK)


/datum/quirk/darkpack/primal_perception/add(client/client_source)
	quirk_holder.grant_language(/datum/language/primal_tongue, UNDERSTOOD_LANGUAGE, LANGUAGE_SPLAT)

/datum/quirk/darkpack/primal_perception/remove()
	quirk_holder.remove_language(/datum/language/primal_tongue, UNDERSTOOD_LANGUAGE, LANGUAGE_SPLAT)
