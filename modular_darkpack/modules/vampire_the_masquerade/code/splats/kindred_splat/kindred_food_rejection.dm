/mob/living/carbon/proc/kindred_digest(seconds_per_tick)
	var/can_eat = HAS_TRAIT(src, TRAIT_EAT_FOOD)
	var/list/to_digest = list()
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		if(reagent.self_consuming)
			continue
		if(istype(reagent, /datum/reagent/blood) || (can_eat && istype(reagent, /datum/reagent/consumable)))
			to_digest[reagent.type] = reagent.metabolization_rate * metabolism_efficiency * seconds_per_tick
	for(var/reagent_type in to_digest)
		reagents.remove_reagent(reagent_type, to_digest[reagent_type])

///if theres anything that is not blood/self_consuming, kindred will vomit
/mob/living/carbon/proc/kindred_rejects(datum/reagent/reagent)
	if(reagent.self_consuming || istype(reagent, /datum/reagent/blood))
		return FALSE
	if(istype(reagent, /datum/reagent/consumable) && HAS_TRAIT(src, TRAIT_EAT_FOOD))
		return FALSE
	return TRUE

/mob/living/carbon/proc/kindred_has_rejected_reagents()
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		if(kindred_rejects(reagent))
			return TRUE
	var/obj/item/organ/stomach/belly = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(belly?.reagents)
		for(var/datum/reagent/reagent as anything in belly.reagents.reagent_list)
			if(reagent.volume > belly.food_reagents[reagent.type] && kindred_rejects(reagent))
				return TRUE
	return FALSE

/mob/living/carbon/proc/kindred_purge_food()
	to_chat(src, span_warning("Your dead flesh rejects it. It comes back up as cold, spoiled vitae."))
	var/turf/location = get_turf(src)
	location?.add_vomit_floor(src, /obj/effect/decal/cleanable/vomit/spoiled_vitae, purge_ratio = 0)

	var/obj/item/organ/stomach/belly = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(belly?.reagents)
		for(var/datum/reagent/eaten as anything in belly.reagents.reagent_list.Copy())
			if(eaten.self_consuming)
				continue
			var/eaten_volume = eaten.volume - belly.food_reagents[eaten.type]
			if(eaten_volume > 0)
				belly.reagents.remove_reagent(eaten.type, eaten_volume)

	for(var/datum/reagent/reagent as anything in reagents.reagent_list.Copy())
		if(!reagent.self_consuming)
			reagents.del_reagent(reagent.type)

/// fake blood which does not trigger frenzy
/obj/effect/decal/cleanable/vomit/spoiled_vitae
	name = "spoiled vitae"
	desc = "A small pool of dark blood, it smells of rot."
	icon_state = "gibbl1"
	random_icon_states = list("gibbl1", "gibbl2", "gibbl3", "gibbl4", "gibbl5")
	color = BLOOD_COLOR_RED
	beauty = -100
