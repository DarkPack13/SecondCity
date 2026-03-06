/datum/action/cooldown/power/gift/city_running
	name = "City Running"
	#warn rewrite
	desc = "Climb Like An Ape"
	rank = 1
	rage_cost = 1

/datum/action/cooldown/power/gift/city_running
	var/mob/living/living_owner = astype(owner)
	living_owner?.apply_status_effect(/datum/status_effect/city_running)

/datum/status_effect/city_running
	id = "city_running"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REPLACE
	alert_type = /atom/movable/screen/alert/status_effect/gift/city_running

/datum/status_effect/city_running/on_apply()
	. = ..()

	ADD_TRAIT(owner, TRAIT_CITY_RUNNING, GIFT_TRAIT)

/datum/status_effect/city_running/on_remove()
	REMOVE_TRAIT(owner, TRAIT_CITY_RUNNING, GIFT_TRAIT)

	return ..()

/atom/movable/screen/alert/status_effect/gift/city_running
	name = /datum/action/cooldown/power/gift/city_running::name
	desc = /datum/action/cooldown/power/gift/city_running::desc
	overlay_state = /datum/action/cooldown/power/gift/city_running::button_icon_state
