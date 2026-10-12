/datum/status_effect/blood_bond
	id = "circulation"
	duration = INFINITY
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/blood_bond
	/// The Regnant of a Blood Bond, null unless Blood Bond made in round
	var/mob/living/regnant_name

/datum/status_effect/blood_bond/on_creation(mob/living/new_owner, mob/living/regnant)
	. = ..()
	if(.)
		linked_alert.desc = "You're in blood bond with [regnant.real_name]!"
		regnant_name = regnant

/atom/movable/screen/alert/status_effect/blood_bond
	name = "Blood Bond"
	desc = "You're in a blood bond!"
	icon_state = "blood_bond"
	icon = 'modular_darkpack/modules/vitae/icons/blood_bond.dmi'
