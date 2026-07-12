// /datum/action/cooldown/power/gift/apecrafts_blessings


/datum/action/cooldown/power/gift/city_running
	name = "City Running"
	desc = {"The player spends a point of Rage. For the rest of the scene, the character may climb at her full movement speed,
	and the difficulty of all Athletics rolls to navigate is reduced by two."}
	rank = 1
	rage_cost = 1

/datum/action/cooldown/power/gift/city_running/Activate(atom/target)
	. = ..()
	var/mob/living/living_owner = astype(owner)
	living_owner?.apply_status_effect(/datum/status_effect/city_running)


/datum/status_effect/city_running
	id = "city_running"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REPLACE
	alert_type = /atom/movable/screen/alert/status_effect/gift/city_running

/atom/movable/screen/alert/status_effect/gift/city_running
	name = /datum/action/cooldown/power/gift/city_running::name
	desc = /datum/action/cooldown/power/gift/city_running::desc
	overlay_state = /datum/action/cooldown/power/gift/city_running::button_icon_state


// /datum/action/cooldown/power/gift/master_of_fire
