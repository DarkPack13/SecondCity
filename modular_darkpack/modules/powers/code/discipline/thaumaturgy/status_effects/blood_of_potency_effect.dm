/datum/status_effect/blood_of_potency
	id = "blood_of_potency"
	duration = 30 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/blood_of_potency
	var/stored_generation

/datum/status_effect/blood_of_potency/on_creation(mob/living/new_owner, generation, time)
	. = ..()
	if(time)
		duration = time
	var/mob/living/carbon/carbon_owner = owner
	stored_generation = carbon_owner.dna.species.generation
	carbon_owner.dna.species.generation = generation
	carbon_owner.update_blood_hud()

/datum/status_effect/blood_of_potency/on_remove()
	. = ..()

	//Can't do initial() due to it giving bad results.
	var/mob/living/carbon/carbon_owner = owner
	carbon_owner.dna.species.generation = stored_generation
	stored_generation = null

	owner.update_blood_hud()

	if(owner.bloodpool > owner.maxbloodpool)
		owner.bloodpool = owner.maxbloodpool

/atom/movable/screen/alert/status_effect/blood_of_potency
	name = "Blood of Potency"
	desc = "You can feel your blood being stronger!"
	icon_state = "blooddrunk"
