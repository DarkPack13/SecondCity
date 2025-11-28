/datum/status_effect/awe //Used for powers that force a target to walk to you.
	id = "awe"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 SECONDS //Should probably make the duration variable and prompted in the proc.
	tick_interval = 2
	alert_type = /atom/movable/screen/alert/status_effect/awe
	var/mob/living/carbon/human/source

/atom/movable/screen/alert/status_effect/awe
	name = "Awe"
	desc = "That person sure seems alluring... I should get closer."
	icon_state = "hypnosis"

/datum/status_effect/awe/on_creation(mob/living/carbon/new_owner, mob/living/carbon/human/new_source)
	. = ..()
	source = new_source

/datum/status_effect/awe/tick()
	var/mob/living/carbon/H = owner
	//H.walk_to_caster(source)
	H.Immobilize(2) //So our victim doesn't just walk in the opposite direction.

/datum/status_effect/awe/Destroy()
	source = null
	return ..()
