#define KINDRED_REJECTION_PROB 5
#define EAT_FOOD_REJECTION_WARNING 20
#define EAT_FOOD_REJECTION_LIMIT 30
///Fullness at which eating is refused (see TryToEat in edible.dm), minus the 10 it adds for the bite being eaten
#define EAT_FOOD_FULLNESS_LIMIT 590

///Currently as nothing in blood metabolizes, blood will stuck in bloodstream and this fixes it
/mob/living/carbon/proc/kindred_digest(seconds_per_tick)
	for(var/datum/reagent/blood/blood in reagents.reagent_list.Copy())
		if(!blood.self_consuming)
			reagents.remove_reagent(blood.type, blood.metabolization_rate * metabolism_efficiency * seconds_per_tick)

/mob/living/carbon/proc/kindred_rejects(datum/reagent/reagent)
	return !(reagent.self_consuming || istype(reagent, /datum/reagent/blood))

/mob/living/carbon/proc/kindred_rejected_volume()
	var/rejected_volume = 0
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		if(kindred_rejects(reagent))
			rejected_volume += reagent.volume
	return rejected_volume

/mob/living/carbon/proc/kindred_purge_food(message)
	to_chat(src, message)
	var/turf/location = get_turf(src)
	location?.add_vomit_floor(src, /obj/effect/decal/cleanable/vomit/spoiled_vitae, purge_ratio = 0)
	playsound(src, 'sound/effects/splat.ogg', 50, TRUE)

	for(var/datum/reagent/reagent as anything in reagents.reagent_list.Copy())
		if(kindred_rejects(reagent))
			reagents.del_reagent(reagent.type)

/datum/splat/vampire/kindred
	var/warned_food_rejection = FALSE

/datum/splat/vampire/kindred/proc/handle_food_rejection(seconds_per_tick)
	//Vamps dont vomit if they are crit
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return

	//If vamp does not have eatfood trait they will randomly throw up rejected chemicals. Otherwise they can decide when to do it
	if(!HAS_TRAIT(owner, TRAIT_EAT_FOOD))
		if(SPT_PROB(KINDRED_REJECTION_PROB, seconds_per_tick) && owner.kindred_rejected_volume() > 0)
			owner.kindred_purge_food(span_warning("Your body rejects it. It comes back up as spoiled vitae."))
		return

	//Vamps with eatfood trait gets a warning when theres enough rejected chemicals in bloodstream.
	var/rejected_volume = owner.kindred_rejected_volume()
	if(rejected_volume >= EAT_FOOD_REJECTION_LIMIT)
		owner.kindred_purge_food(span_warning("Your body can't hold any more of it. It comes back up as spoiled vitae."))
		warned_food_rejection = FALSE
	else if(rejected_volume > EAT_FOOD_REJECTION_WARNING || owner.get_fullness() > EAT_FOOD_FULLNESS_LIMIT)
		if(!warned_food_rejection)
			to_chat(owner, span_warning("Something you've taken in sits heavy and wrong in your gut. It won't stay down much longer. (You may use IC > Purge to throw it up.)"))
			warned_food_rejection = TRUE
	else
		warned_food_rejection = FALSE

//Verb for players with eatfood
GAME_VERB_PROC_DESC(/mob/living/carbon/human, kindred_purge, "Purge", "Throw up everything your body can't take in.", "IC")
	if(!get_kindred_splat(src) || IS_UNCONSCIOUS_OR_CRIT(src))
		return
	if(kindred_rejected_volume() <= 0)
		to_chat(src, span_warning("There's nothing in your body that needs to be rejected."))
		return
	kindred_purge_food(span_warning("You force yourself to bring up what your dead body can't use, along with a mouthful of spoiled vitae."))

///Fake blood which does not trigger frenzy
/obj/effect/decal/cleanable/vomit/spoiled_vitae
	name = "spoiled vitae"
	desc = "A small pool of dark blood, it smells of rot."
	icon_state = "gibbl1"
	random_icon_states = list("gibbl1", "gibbl2", "gibbl3", "gibbl4", "gibbl5")
	color = BLOOD_COLOR_RED
	beauty = -100

#undef KINDRED_REJECTION_PROB
#undef EAT_FOOD_REJECTION_WARNING
#undef EAT_FOOD_REJECTION_LIMIT
#undef EAT_FOOD_FULLNESS_LIMIT
