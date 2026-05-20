/datum/action/cooldown/power/gift/balance
	name = "Balance"
	desc = {"The Stargazer achieves near
perfect balance and can walk across ledges, ropes, or other
narrow objects regardless of how slippery or mobile the
surface is."}
	button_icon_state = "balance"
	rank = 1
	willpower_cost = 2

/datum/action/cooldown/power/gift/balance/IsAvailable(feedback)
	. = ..()
	if(owner.has_status_effect(/datum/status_effect/balance))
		if(feedback)
			to_chat(owner, span_warning("[name] cannot be used again right now, it is already active."))
		return FALSE

/datum/action/cooldown/power/gift/balance/Activate(atom/target)
	. = ..()
	var/mob/living/living_owner = astype(owner)

	living_owner.apply_status_effect(/datum/status_effect/balance)

/datum/status_effect/balance //It also gives you -3 difficulty to climbing.
	id = "balance"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

/datum/status_effect/balance/on_apply()
	. = ..()

	to_chat(owner, span_notice("You feel a sense of balance like no other; it's hard to imagine you could topple."))
	ADD_TRAIT(owner, TRAIT_NO_SLIP_WATER, GIFT_TRAIT) //no lube combat

/datum/status_effect/balance/on_remove()
	ADD_TRAIT(owner, TRAIT_NO_SLIP_WATER, GIFT_TRAIT)
	to_chat(owner, span_warning("Your footing feels... uncertain, again."))
	return ..()
