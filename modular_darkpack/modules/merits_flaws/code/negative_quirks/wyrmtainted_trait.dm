/datum/quirk/darkpack/wyrmtainted_trait
	name = "Wyrmtainted"
	desc = {"Whether through your own twisted service to the Wyrm, an unfortunate
			quirk of heredity or just because of a supernatural accident, you reek
			of the enemy's blight. A number of Gifts allow shapechangers to notice
			your foul stench and most may want to kill you outright. This is a
			risky Flaw!"}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 53)
	value = -4
	mob_trait = TRAIT_WYRMTAINTED
	gain_text = span_notice("The Wyrm defiles your essence.")
	lose_text = span_notice("Your essence is purified from the Wyrm's influence.")
	icon = FA_ICON_WORM
	failure_message = "Your essence is purified from the Wyrm's influence."
	allowed_splats = list(SPLAT_KINFOLK)
