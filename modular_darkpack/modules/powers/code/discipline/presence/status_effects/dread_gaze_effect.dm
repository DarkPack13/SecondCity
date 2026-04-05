/datum/status_effect/dread_gaze //Used for extended effect of dreadgaze
	id = "dread_gaze"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/dread_gaze
	var/mob/living/carbon/human/source
	var/stored_dexterity

/datum/status_effect/dread_gaze/on_creation(mob/living/new_owner, generation, time)
	. = ..()
	if(time)
		duration = time
	stored_dexterity = owner.st_get_stat(STAT_DEXTERITY)
	owner.st_set_stat(STAT_DEXTERITY, 1)	//Nukes your dex

/datum/status_effect/dread_gaze/on_remove()
	. = ..()

	//Returns your dex to what it was.
	owner.st_set_stat(STAT_DEXTERITY, stored_dexterity)
	stored_dexterity = null

/atom/movable/screen/alert/status_effect/dread_gaze
	name = "Overwhelming Dread"
	desc = "That person- that THING is a monster! I don't stand a chance!"
	icon_state = "hypnosis"
