/datum/action/cooldown/power/fomori_power/chameleon_coloration
	name = "Chameleon Coloration"
	desc = "Blend into the background to strike unseen."
	button_icon_state = "chameleon_coloration"
	rank = 1 // of 1

	var/activated = FALSE

/datum/action/cooldown/power/fomori_power/chameleon_coloration/Activate(atom/target)
	. = ..()
	if(activated)
		activated = FALSE
		owner.alpha = 255
		UnregisterSignal(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_UNARMED_ATTACK))
	else
		activated = TRUE
		RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
		RegisterSignal(owner, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_attack_hand))
		var/mob/living/living_owner = astype(owner)
		living_owner.apply_status_effect(/datum/status_effect/chameleon_coloration)

/datum/action/cooldown/power/fomori_power/chameleon_coloration/proc/on_move(atom/movable/source, atom/old_loc, move_dir, forced, list/atom/old_locs)
	SIGNAL_HANDLER

	owner.alpha = 200

/datum/action/cooldown/power/fomori_power/chameleon_coloration/proc/on_attack_hand(mob/living/carbon/human/source, atom/target, proximity, list/modifiers)
	SIGNAL_HANDLER

	if(!proximity)
		return
	owner.alpha = 200

/datum/status_effect/chameleon_coloration
	id = "chameleon_coloration"
	duration = INFINITY

	status_type = STATUS_EFFECT_UNIQUE

	alert_type = /atom/movable/screen/alert/status_effect/chameleon_coloration

/datum/status_effect/chameleon_coloration/tick(seconds_per_tick)
	. = ..()
	owner.alpha = max(owner.alpha - 50, 0) // TODO: use animate magic to make this look better

/atom/movable/screen/alert/status_effect/chameleon_coloration
	name = "Chameleon Coloration"
	desc = "You are blending in with your surroundings."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "riddle" // TODO: get an icon for this
