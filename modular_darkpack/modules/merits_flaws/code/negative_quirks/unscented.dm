/datum/quirk/darkpack/unscented
	name = "Unscented"
	desc = {"For some reason, you have no discernible scent; it's completely missing from your body.
			While this condition might be an advantage when hiding from predators, it's a disadvantage
			among werewolves. They might pounce on you, unaware you're Kin. No Gift, such as Scent of
			the True Form, can detect you as Kinfolk."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 55)
	value = -1
	mob_trait = TRAIT_UNSCENTED
	gain_text = span_notice("You notice that your body has no discernable odor.")
	lose_text = span_notice("Scent returns to your body.")
	icon = FA_ICON_WIND
	failure_message = "Scent returns to your body."
	allowed_splats = list(SPLAT_KINFOLK)

	// DARKPACK TODO - If Auspex Smell is ever decoupled from Olfaction check for this.
