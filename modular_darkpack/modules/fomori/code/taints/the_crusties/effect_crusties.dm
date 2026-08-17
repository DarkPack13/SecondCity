/////////////////////////////////////////////
// stolen almost entirely from code/game/objects/effects/effect_system/effects_sparks.dm
/////////////////////////////////////////////

/proc/do_crusties(number, cardinal_only, atom/source, atom/holder = null, crustie_type = /datum/effect_system/basic/crustie_spread)
	var/datum/effect_system/basic/crustie_spread/crusties = new crustie_type(get_turf(source), number, cardinal_only)
	if (holder)
		crusties.attach(holder)
	crusties.autocleanup = TRUE
	crusties.start()

/obj/effect/particle_effect/crusties
	name = "crusties"
	icon_state = "m_shield"
	anchored = TRUE
	/// Timer id for the timer that will wipe us out
	var/delete_timer_id = TIMER_ID_NULL
	/// Mob for DNA
	var/mob/living/living_source

/obj/effect/particle_effect/crusties/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/particle_effect/crusties/LateInitialize()
	RegisterSignals(src, list(COMSIG_MOVABLE_CROSS, COMSIG_MOVABLE_CROSS_OVER), PROC_REF(crusties_touched))
	flick(icon_state, src)
	playsound(src, SFX_SPARKS, 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	var/turf/location = loc
	if(isturf(location))
		affect_location(location, just_initialized = TRUE)
	decay_in(2 SECONDS)

/obj/effect/particle_effect/crusties/Destroy()
	return ..()

/// Sets up our death effects given the passed in duration
/obj/effect/particle_effect/crusties/proc/decay_in(decay_time)
	if(delete_timer_id != TIMER_ID_NULL)
		deltimer(delete_timer_id)
	delete_timer_id = QDEL_IN_STOPPABLE(src, decay_time + world.tick_lag)

/obj/effect/particle_effect/crusties/Destroy()
	var/turf/location = loc
	if(isturf(location))
		affect_location(location)
	return ..()

/obj/effect/particle_effect/crusties/Move()
	. = ..()
	var/turf/location = loc
	if(isturf(location))
		affect_location(location)

/*
* Apply the effects of this crustie to its location.
*
* When the crustie is first created, Cross() and Crossed() don't get called,
* so for the first initialization, we make sure to specifically invoke the
* behavior of the crustie on all the mobs and objects in the location.
* turf/location - The place the crustie is affectiong
* just_initialized - If the crustie is just being created, and we need to manually affect everything in the location
*/
/obj/effect/particle_effect/crusties/proc/affect_location(turf/location, just_initialized = FALSE)
	if(just_initialized)
		for(var/atom/movable/crusted in location)
			crusties_touched(src, crusted)

/*
* This is called when anything passes through the same tiles as a crustie, or when a crustie passes through something's tile.
*
* This is invoked by the signals sent by every atom when they're crossed or crossing something. It
* signifies that something has been touched by crusties, and should be affected by possible pyrotechnic affects..
* datum/source - Can either be the crustie itself or an object that just walked into it
* mob/living/crusted - What was touched by the crustie
*/
/obj/effect/particle_effect/crusties/proc/crusties_touched(datum/source, atom/crusted)
	SIGNAL_HANDLER

	var/datum/component/crusties/crust_keeper = crusted.GetComponent(/datum/component/crusties)
	var/list/living_source_blood_DNA = living_source.get_blood_dna_list()
	if(crust_keeper && !(living_source_blood_DNA in crust_keeper.dna_sequences))
		crust_keeper.dna_sequences += living_source_blood_DNA
	else
		AddComponent(/datum/component/crusties, living_source_blood_DNA)

	if(ishuman(crusted))
		var/mob/living/carbon/human/crusted_human = crusted
		for(var/obj/item/anything in crusted_human.get_visible_items())
			crusties_touched(src, anything)

/datum/effect_system/basic/crustie_spread
	effect_type = /obj/effect/particle_effect/crusties
	step_delay = 10.35 SECONDS // chosen so we will always take at least the duration of our animation to finish

/datum/effect_system/basic/crustie_spread/generate_effect()
	var/obj/effect/particle_effect/crusties/crustie = ..()
	if(holder)
		crustie.living_source = holder
		if(ishuman(holder))
			var/mob/living/carbon/human/crusted_human = holder
			for(var/obj/item/anything in crusted_human.get_visible_items())
				crustie.crusties_touched(src, anything)

	crustie.decay_in(last_loop_length)

/datum/effect_system/basic/crustie_spread/get_step_count()
	return rand(2, 3) // never 1 cause 1 looks dumb

/datum/effect_system/basic/crustie_spread/move_failed(datum/move_loop/loop, obj/effect/failed)
	if(QDELETED(failed))
		return
	var/obj/effect/particle_effect/crusties/crustie = failed
	crustie.decay_in(0.1 SECONDS)
