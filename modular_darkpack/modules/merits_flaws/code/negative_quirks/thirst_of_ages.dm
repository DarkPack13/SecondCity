/datum/quirk/darkpack/thirst_of_ages
	name = "Thirst Of Ages"
	desc = "Some particularly old vampires find themselves unable to subsist off of mortal blood. You are only capable of feeding off of supernaturals."
	value = -15
	mob_trait = TRAIT_THIRST_OF_AGES
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_NAGARAJA)	//Eating organs for vitae would bypass this downside.
	icon = FA_ICON_TEETH
