/datum/quirk/darkpack/blush_of_health
	name = "Blush of Health"
	desc = "Some Kindred are capable of maintaining the illusion of life more convincingly than their peers. With minimal effort, you can appear flushed, warm, and breathing, making it significantly harder for others to identify you as one of the Undead. While active, you seem more alive than before."
	value = 1
	mob_trait = TRAIT_BLUSH_OF_HEALTH
	gain_text = span_notice("A faint warmth spreads across your skin as the blush of health settles over you.")
	lose_text = span_notice("The warmth fades from your skin, leaving you pallid and cold once more.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_HEART

/datum/quirk/darkpack/blush_of_health/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	if(. == FALSE)
		return
