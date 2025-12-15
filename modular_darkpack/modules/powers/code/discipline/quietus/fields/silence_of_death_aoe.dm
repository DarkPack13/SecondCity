//The AOE proximity monitor for Quietus 1
//It is designed to apply the trait 'silenced' and 'mute' to all targets in its area

/datum/proximity_monitor/advanced/silence_of_death
	edge_is_a_field = TRUE
	var/list/silenced_mobs

/datum/proximity_monitor/advanced/silence_of_death/New(atom/_host, range, _ignore_if_not_on_turf = TRUE)
	. = ..()
	silenced_mobs = list()
	if(ishuman(_host))
		ADD_TRAIT(_host, TRAIT_SILENCED, DISCIPLINE_TRAIT)
		silenced_mobs |= _host

/datum/proximity_monitor/advanced/silence_of_death/Destroy()
	for(var/mob/living/carbon/human/H in silenced_mobs)
		REMOVE_TRAIT(H, TRAIT_SILENCED, DISCIPLINE_TRAIT)
		REMOVE_TRAIT(H, TRAIT_MUTE, DISCIPLINE_TRAIT)
	silenced_mobs = null
	return ..()

/datum/proximity_monitor/advanced/silence_of_death/on_entered(turf/source, atom/movable/entered, turf/old_loc)
	. = ..()
	if(QDELETED(src))
		return
	if(!isliving(entered))
		return
	if(entered in silenced_mobs)
		return

	var/mob/living/carbon/human/H = entered
	ADD_TRAIT(H, TRAIT_SILENCED, DISCIPLINE_TRAIT)

	if(H != host)
		ADD_TRAIT(H, TRAIT_MUTE, DISCIPLINE_TRAIT)

	H.adjust_confusion_up_to(15 SECONDS, 15 SECONDS)

	silenced_mobs |= H

/datum/proximity_monitor/advanced/silence_of_death/on_uncrossed(turf/source, atom/movable/gone, direction)
	. = ..()
	if(QDELETED(src))
		return
	if(!isliving(gone))
		return
	if(!(gone in silenced_mobs))
		return
	if(gone == host)
		return

	var/mob/living/carbon/human/H = gone
	REMOVE_TRAIT(H, TRAIT_SILENCED, DISCIPLINE_TRAIT)
	REMOVE_TRAIT(H, TRAIT_MUTE, DISCIPLINE_TRAIT)
	silenced_mobs -= H

/datum/proximity_monitor/advanced/silence_of_death/on_z_change()
	if(QDELETED(src))
		return
	for(var/mob/living/carbon/human/H in silenced_mobs)
		REMOVE_TRAIT(H, TRAIT_SILENCED, DISCIPLINE_TRAIT)
		REMOVE_TRAIT(H, TRAIT_MUTE, DISCIPLINE_TRAIT)
	silenced_mobs.Cut()

/datum/proximity_monitor/advanced/silence_of_death/cleanup_field_turf(turf/target)
	if(QDELETED(src))
		return
	for(var/mob/living/carbon/human/H in target.contents)
		if((H in silenced_mobs) && H != host)
			REMOVE_TRAIT(H, TRAIT_SILENCED, DISCIPLINE_TRAIT)
			REMOVE_TRAIT(H, TRAIT_MUTE, DISCIPLINE_TRAIT)
			silenced_mobs -= H
