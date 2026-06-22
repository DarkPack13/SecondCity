/datum/action/cooldown/power/gift/speed_of_thought
	name = "Speed of Thought"
	desc = "The Garou doubles her running speed."
	button_icon_state = "smooth_move"

	gnosis_cost = 1

	rank = 1

/datum/action/cooldown/power/gift/speed_of_thought/Activate(atom/target)
	. = ..()
	var/mob/living/living_owner = astype(owner)
	living_owner?.apply_status_effect(/datum/status_effect/speed_of_thought)


/datum/status_effect/speed_of_thought
	id = "speed_of_thought"
	duration = 1 SCENES

	status_type = STATUS_EFFECT_UNIQUE

	alert_type = /atom/movable/screen/alert/status_effect/gift/speed_of_thought

/datum/status_effect/speed_of_thought/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/speed_of_thought)

/datum/status_effect/speed_of_thought/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/speed_of_thought)
	return ..()


/atom/movable/screen/alert/status_effect/gift/speed_of_thought
	name = /datum/action/cooldown/power/gift/speed_of_thought::name
	desc = /datum/action/cooldown/power/gift/speed_of_thought::desc
	overlay_state = /datum/action/cooldown/power/gift/speed_of_thought::button_icon_state


/datum/movespeed_modifier/speed_of_thought
	multiplicative_slowdown = -0.5

