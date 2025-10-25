/datum/status_effect/celerity
	// All IDs are the same to prevent stacking multiple Celerity statuses
	id = "celerity"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null

	var/click_cooldown_modifier
	var/speed_bonus

/datum/status_effect/celerity/on_apply()
	. = ..()
	if (!.)
		return

	owner.add_movespeed_modifier(speed_bonus)

	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_moved))

/datum/status_effect/celerity/on_remove()
	. = ..()

	owner.remove_movespeed_modifier(speed_bonus)

	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

/datum/status_effect/celerity/nextmove_modifier()
	return click_cooldown_modifier

// Create Celerity visual effect when moving
/datum/status_effect/celerity/proc/handle_moved(mob/living/source, atom/newloc, dir)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(celerity_visual), newloc, dir)

/datum/status_effect/celerity/proc/celerity_visual(atom/newloc, dir)
	new /obj/effect/celerity(owner.loc, owner)

	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

// Status effect ranks
/datum/status_effect/celerity/one
	click_cooldown_modifier = 0.90
	speed_bonus = /datum/movespeed_modifier/celerity

/datum/status_effect/celerity/two
	click_cooldown_modifier = 0.80
	speed_bonus = /datum/movespeed_modifier/celerity2

/datum/status_effect/celerity/three
	click_cooldown_modifier = 0.70
	speed_bonus = /datum/movespeed_modifier/celerity3

/datum/status_effect/celerity/four
	click_cooldown_modifier = 0.60
	speed_bonus = /datum/movespeed_modifier/celerity4

/datum/status_effect/celerity/five
	click_cooldown_modifier = 0.50
	speed_bonus = /datum/movespeed_modifier/celerity5
