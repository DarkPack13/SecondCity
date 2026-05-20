/datum/action/cooldown/power/gift/whisper_catching
	name = "Whisper Catching"
	desc = {"This Gift allows a
Shadow Lord to supernaturally overhear conversations, giving them
a chance to get a heads up on any potential plots against the
Garou or their Kin."}
	button_icon_state = "whisper_catching"
	rank = 1
	willpower_cost = 1

/datum/action/cooldown/power/gift/whisper_catching/Activate(atom/target)
	. = ..()
	var/mob/living/living_owner = astype(owner)

	living_owner.apply_status_effect(/datum/status_effect/whisper_catching)

/datum/status_effect/whisper_catching
	duration = 	1 SCENES
	id = "whisper_catching"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/gift/whisper_catching

/datum/status_effect/whisper_catching/on_apply()
	. = ..()
	owner.add_traits(list(TRAIT_GOOD_HEARING, TRAIT_XRAY_HEARING), GIFT_TRAIT)
	to_chat(owner, span_warning("Whispers find their way to your ears on the wind."))

/datum/status_effect/whisper_catching/on_remove()
	owner.remove_traits(list(TRAIT_GOOD_HEARING, TRAIT_XRAY_HEARING), GIFT_TRAIT)
	to_chat(owner, span_warning("The world seems quiet again."))
	return ..()

/atom/movable/screen/alert/status_effect/gift/whisper_catching
	name = /datum/action/cooldown/power/gift/whisper_catching::name
	desc = /datum/action/cooldown/power/gift/whisper_catching::desc
	overlay_state = /datum/action/cooldown/power/gift/whisper_catching::button_icon_state
