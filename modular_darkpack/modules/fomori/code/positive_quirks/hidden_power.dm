/datum/quirk/darkpack/hidden_power
	name = "Hidden Power"
	desc = {"None of your powers or taints are physically obvious, and can be retracted or otherwise hidden."}
	value = 4
	mob_trait = TRAIT_FOMORI_HIDDEN_POWER
	gain_text = span_notice("You feel your corruption being hidden.")
	lose_text = span_notice("You feel your corruption rise to the forefront.")
	icon = FA_ICON_GHOST
	allowed_splats = list(SPLAT_FOMORI)
	failure_message =  "Your corruption is too strong to hide your powers."
