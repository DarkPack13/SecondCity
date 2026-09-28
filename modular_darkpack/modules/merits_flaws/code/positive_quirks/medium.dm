/datum/quirk/darkpack/medium
	name = "Medium"
	desc = "You may listen to, but not see, ghosts."
	ttrpg_sources = list(/datum/source_book/vtm20 = 493)
	value = 2
	mob_trait = TRAIT_LOCAL_SIXTHSENSE
	gain_text = span_notice("You hear voices in your head.")
	lose_text = span_notice("You no longer hear voices in your head.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_GHOST
