/datum/quirk/darkpack/veiled
	name = "Veiled"
	desc = {"You may believe in Gaia and the Garou way with all your heart and soul,
			but, for some reason, you're not immune to the Delirium. Gifts such as
			Rending the Veil and the Rite of the Parted Veil have no effect on you.
			You do receive a +1 bonus on the Delirium Chart and retain all memories
			of what you see, but the sight of a Garou in Crinos form still invokes
			some sort of instinctive, uncontrollable reaction in you."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 54)
	value = -5
	mob_trait = TRAIT_VEILED
	gain_text = span_notice("You lose your resistance to the Delirium.")
	lose_text = span_notice("You regain your ability to resist the Delirium.")
	icon = FA_ICON_EYE_LOW_VISION
	failure_message = "You regain your ability to resist the Delirium."
	allowed_splats = list(SPLAT_KINFOLK)
