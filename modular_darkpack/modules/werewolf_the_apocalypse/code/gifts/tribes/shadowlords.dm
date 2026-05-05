/datum/action/cooldown/power/gift/aura_of_confidence
	name = "Aura of Confidence"
	desc = "The werewolf projects an aura of superiority, preventing attempts to find flaws or read auras."
	// button_icon_state = "aura_of_confidence"
	rank = 1

// Effect is permenent
/datum/action/cooldown/power/gift/aura_of_confidence/Grant(mob/granted_to)
	. = ..()
	ADD_TRAIT(granted_to, TRAIT_AURA_OF_CONFIDENCE, GIFT_TRAIT)
	SEND_SIGNAL(granted_to, COMSIG_MOB_UPDATE_AURA)

/datum/action/cooldown/power/gift/aura_of_confidence/Remove(mob/removed_from)
	. = ..()
	REMOVE_TRAIT(removed_from, TRAIT_AURA_OF_CONFIDENCE, GIFT_TRAIT)
	SEND_SIGNAL(removed_from, COMSIG_MOB_UPDATE_AURA)
