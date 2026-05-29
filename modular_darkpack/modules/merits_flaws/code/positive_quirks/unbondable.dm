// V20 p. 494
/datum/quirk/darkpack/unbondable
	name = "Unbondable"
	desc = "You are immune to being blood bound. Tremere cannot take this Merit."
	value = 5 // Guh, this is a 6pt merit for ghouls but i dont super care to bloat the menu without a way to hide ones you cant take..
	mob_trait = TRAIT_UNBONDABLE
	icon = FA_ICON_CHAIN_BROKEN
	allowed_splats = list(SPLAT_KINDRED, SPLAT_GHOUL)
	excluded_clans = list(VAMPIRE_CLAN_TREMERE)
