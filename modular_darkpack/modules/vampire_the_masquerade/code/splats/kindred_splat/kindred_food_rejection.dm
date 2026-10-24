#define EAT_FOOD_REJECTION_WARNING 20
#define EAT_FOOD_REJECTION_LIMIT 30

///currently as nothing in blood metabolizes, blood will stuck in bloodstream and this fixes it
/mob/living/carbon/proc/kindred_digest(seconds_per_tick)
	for(var/datum/reagent/blood/blood in reagents.reagent_list.Copy())
		if(!blood.self_consuming)
			reagents.remove_reagent(blood.type, blood.metabolization_rate * metabolism_efficiency * seconds_per_tick)

///anything that is not blood/self_consuming
/mob/living/carbon/proc/kindred_rejects(datum/reagent/reagent)
	if(reagent.self_consuming || istype(reagent, /datum/reagent/blood))
		return FALSE
	return TRUE

/mob/living/carbon/proc/kindred_rejected_volume()
	. = 0
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		if(kindred_rejects(reagent))
			. += reagent.volume
	var/obj/item/organ/stomach/belly = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(belly?.reagents)
		for(var/datum/reagent/reagent as anything in belly.reagents.reagent_list)
			if(kindred_rejects(reagent))
				. += max(reagent.volume - belly.food_reagents[reagent.type], 0)

/mob/living/carbon/proc/kindred_purge_food(message)
	to_chat(src, message)
	var/turf/location = get_turf(src)
	location?.add_vomit_floor(src, /obj/effect/decal/cleanable/vomit/spoiled_vitae, purge_ratio = 0)

	var/obj/item/organ/stomach/belly = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(belly?.reagents)
		for(var/datum/reagent/eaten as anything in belly.reagents.reagent_list.Copy())
			if(!kindred_rejects(eaten))
				continue
			var/eaten_volume = eaten.volume - belly.food_reagents[eaten.type]
			if(eaten_volume > 0)
				belly.reagents.remove_reagent(eaten.type, eaten_volume)

	for(var/datum/reagent/reagent as anything in reagents.reagent_list.Copy())
		if(kindred_rejects(reagent))
			reagents.del_reagent(reagent.type)

/datum/splat/vampire/kindred
	var/warned_food_rejection = FALSE

/datum/splat/vampire/kindred/proc/handle_food_rejection(seconds_per_tick)
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return

	if(!HAS_TRAIT(owner, TRAIT_EAT_FOOD))
		if(SPT_PROB(5, seconds_per_tick) && owner.kindred_rejected_volume() > 0)
			owner.kindred_purge_food(span_warning("Your dead flesh rejects it. It comes back up as cold, spoiled vitae."))
		return

	var/rejected_volume = owner.kindred_rejected_volume()
	if(rejected_volume >= EAT_FOOD_REJECTION_LIMIT)
		owner.kindred_purge_food(span_warning("Your stomach can't hold any more of it. It all comes heaving back up in a rush of spoiled vitae."))
		warned_food_rejection = FALSE
	else if(rejected_volume > EAT_FOOD_REJECTION_WARNING)
		if(!warned_food_rejection)
			to_chat(owner, span_warning("Something you've taken in sits heavy and wrong in your dead gut. It won't stay down much longer. (You may use IC > Purge to throw it up.)"))
			warned_food_rejection = TRUE
	else
		warned_food_rejection = FALSE

GAME_VERB_PROC_DESC(/mob/living/carbon/human, kindred_purge, "Purge", "Throw up everything your dead body can't take in.", "IC")
	if(!get_kindred_splat(src) || IS_UNCONSCIOUS_OR_CRIT(src))
		return
	if(kindred_rejected_volume() <= 0)
		to_chat(src, span_warning("There's nothing in you that your body needs to reject."))
		return
	kindred_purge_food(span_warning("You force yourself to bring up what your dead body can't use, along with a mouthful of spoiled vitae."))

/// fake blood which does not trigger frenzy
/obj/effect/decal/cleanable/vomit/spoiled_vitae
	name = "spoiled vitae"
	desc = "A small pool of dark blood, it smells of rot."
	icon_state = "gibbl1"
	random_icon_states = list("gibbl1", "gibbl2", "gibbl3", "gibbl4", "gibbl5")
	color = BLOOD_COLOR_RED
	beauty = -100

#undef EAT_FOOD_REJECTION_WARNING
#undef EAT_FOOD_REJECTION_LIMIT
