/datum/status_effect/silver_slowdown
	id = "slowdown"
	status_type = STATUS_EFFECT_REPLACE
	duration = 5 SECONDS

/datum/status_effect/silver_slowdown/on_apply()
	. = ..()
	var/mob/living/carbon/user = owner
	user.add_movespeed_modifier(/datum/movespeed_modifier/silver_slowdown)

/datum/status_effect/silver_slowdown/on_remove()
	. = ..()
	var/mob/living/carbon/user = owner
	user.remove_movespeed_modifier(/datum/movespeed_modifier/silver_slowdown)
