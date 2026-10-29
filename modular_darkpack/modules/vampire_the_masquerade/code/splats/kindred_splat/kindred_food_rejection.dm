#define KINDRED_REJECTION_PROB 10
#define KINDRED_REJECTION_LIMIT 5
#define EAT_FOOD_REJECTION_WARNING 85
#define EAT_FOOD_REJECTION_LIMIT 100

/datum/splat/vampire/kindred
	var/warned_food_rejection = FALSE

/mob/living/carbon/proc/kindred_rejects(datum/reagent/reagent)
	return !(reagent.self_consuming || istype(reagent, /datum/reagent/blood))

/mob/living/carbon/proc/kindred_rejected_volume()
	var/rejected_volume = 0
	for(var/datum/reagent/reagent in reagents.reagent_list)
		if(kindred_rejects(reagent))
			rejected_volume += reagent.volume
	return rejected_volume

/mob/living/carbon/proc/kindred_purge_food(message)
	to_chat(src, message)
	var/turf/location = get_turf(src)
	if(location)
		new /obj/effect/decal/cleanable/blood/spoiled_vitae(location, null, get_blood_dna_list())
	reagents.del_reagent(/datum/reagent/blood/vitae)// without eat food, kindred may get less vitae when eating organs

	for(var/datum/reagent/reagent in reagents.reagent_list.Copy())
		if(kindred_rejects(reagent))
			reagents.del_reagent(reagent.type)

/mob/living/carbon/proc/kindred_metabolize(seconds_per_tick)
	for(var/datum/reagent/blood/blood in reagents.reagent_list.Copy())
		if(!blood.self_consuming)
			reagents.remove_reagent(blood.type, blood.metabolization_rate * metabolism_efficiency * seconds_per_tick)

/datum/splat/vampire/kindred/proc/handle_food_rejection(seconds_per_tick)
	//Vamps dont vomit if they are crit
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return

	//If vamp does not have eatfood trait they will randomly throw up rejected chemicals. Otherwise they can decide when to do it
	if(!HAS_TRAIT(owner, TRAIT_EAT_FOOD))
		if(SPT_PROB(KINDRED_REJECTION_PROB, seconds_per_tick) && owner.kindred_rejected_volume() >= KINDRED_REJECTION_LIMIT)
			owner.kindred_purge_food(span_warning("Your body rejects the waste it can't use. Thick, dark blood drips from your mouth."))
		return

	//Vamps with eatfood trait gets a warning when theres enough rejected chemicals in bloodstream.
	var/rejected_volume = owner.kindred_rejected_volume()
	if(rejected_volume >= EAT_FOOD_REJECTION_LIMIT)
		owner.kindred_purge_food(span_warning("Your body rejects the waste it can't use. Thick, dark blood drips from your mouth."))
		warned_food_rejection = FALSE
	else if(rejected_volume > EAT_FOOD_REJECTION_WARNING)
		if(!warned_food_rejection)
			to_chat(owner, span_warning("Waste in body is building up in your gut. It won't stay down much longer."))
			warned_food_rejection = TRUE
	else
		warned_food_rejection = FALSE

//Verb for players with eatfood
GAME_VERB_PROC_DESC(/mob/living/carbon/human, kindred_purge, "Purge", "Throw up the waste your dead body can't use.", "IC")
	if(!get_kindred_splat(src) || IS_UNCONSCIOUS_OR_CRIT(src))
		return
	if(kindred_rejected_volume() <= 0)
		to_chat(src, span_warning("There's no waste in your body to purge."))
		return
	kindred_purge_food(span_warning("You force up the waste your body can't use."))

/obj/effect/decal/cleanable/blood/spoiled_vitae
	desc = "A small pool of dark blood, it smells of rot."
	icon_state = "gibbear1"
	random_icon_states = list("gibbear1", "gibbear2", "gibbear3", "gibbear4", "gibbear5")
	bloodiness = 0
	dry_desc = "A small pool of dark blood, it smells of rot."

#undef KINDRED_REJECTION_PROB
#undef KINDRED_REJECTION_LIMIT
#undef EAT_FOOD_REJECTION_WARNING
#undef EAT_FOOD_REJECTION_LIMIT
