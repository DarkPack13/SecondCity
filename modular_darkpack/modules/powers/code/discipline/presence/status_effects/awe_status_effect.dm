/datum/status_effect/awe //Used for powers that force a target to walk to you.
	id = "awe"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/awe
	var/mob/living/carbon/human/source

/atom/movable/screen/alert/status_effect/awe
	name = "Awe"
	desc = "That person sure seems alluring... I should get closer."
	icon_state = "hypnosis"

