
#define FLOOR_DISAPPEAR 3 SECONDS

/datum/quirk/derangement
	name = "Derangement"
	desc = "Suffer from a permanent, incurable derangement that alters your perception."
	icon = FA_ICON_HOUSE_MEDICAL_CIRCLE_EXCLAMATION
	gain_text = span_hypnophrase("You feel off...")
	lose_text = span_notice("You start to feel normal again...")
	medical_record_text = "Patient suffers from a treatment-resistant mental illness."
	value = -8
	hardcore_value = 6
	quirk_flags = QUIRK_PROCESSES
	mob_trait = TRAIT_SHIFTY_EYES // they're deranged, so give them the trait that tells people around them about their crazy eyes
	mail_goodies = list(/obj/effect/spawner/random/contraband/narcotics) // happy pills! :)
	var/process_interval = 3 SECONDS
	var/list/derangements
	COOLDOWN_DECLARE(next_process)

/datum/quirk/derangement/add()
	derangements = subtypesof(/datum/hallucination/malk)

/datum/quirk/derangement/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, next_process))
		return
	if(SPT_PROB(2, seconds_per_tick))
		quirk_holder.cause_hallucination( \
			pick(derangements), \
			"derangement", \
		)
	COOLDOWN_START(src, next_process, process_interval)
	handle_malk_floors()

// largely taken from https://github.com/The-Final-Nights/The-Final-Nights/pull/287
// based on the work of maaacha
/datum/quirk/derangement/proc/handle_malk_floors()
	if(!quirk_holder?.client)
		return
	//Floors go crazy go stupid
	for(var/turf/open/floor in view(quirk_holder))
		if(!prob(7))
			continue
		if(isgroundlessturf(floor))
			continue
		handle_malk_floor(floor)

/datum/quirk/derangement/proc/handle_malk_floor(turf/open/floor)
	var/mutable_appearance/fake_floor = image(floor.icon, floor, floor.icon_state, floor.layer)
	quirk_holder?.client.images += fake_floor
	var/offset = pick(-3,-2, -1, 1, 2, 3)
	var/disappearfirst = rand(1 SECONDS, 3 SECONDS) * abs(offset)
	animate(fake_floor, pixel_y = offset, time = disappearfirst, flags = ANIMATION_RELATIVE)
	addtimer(CALLBACK(src, PROC_REF(malk_floor_stage1), quirk_holder, offset, fake_floor), disappearfirst, TIMER_CLIENT_TIME)

/datum/quirk/derangement/proc/malk_floor_stage1(mob/living/malk, offset, mutable_appearance/fake_floor)
	animate(fake_floor, pixel_y = -offset, time = FLOOR_DISAPPEAR, flags = ANIMATION_RELATIVE)
	addtimer(CALLBACK(src, PROC_REF(malk_floor_stage2), malk, fake_floor), FLOOR_DISAPPEAR, TIMER_CLIENT_TIME)

/datum/quirk/derangement/proc/malk_floor_stage2(mob/living/malk, mutable_appearance/fake_floor)
	malk.client?.images -= fake_floor

/datum/hallucination/malk

/datum/hallucination/malk/ambience

/datum/hallucination/malk/ambience/start()
	var/static/list/ambient_sounds = list(
		'modular_darkpack/modules/powers/sounds/dementation/comic1.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/comic2.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/comic3.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/comic4.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/man_cry.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/woman_cry.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/child_cry.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/man_moan.ogg', // zombie like moaning sounds
		'modular_darkpack/modules/powers/sounds/dementation/woman_moan.ogg',
		'modular_darkpack/modules/powers/sounds/dementation/evillaugh.ogg'
	)
	hallucinator.playsound_local(hallucinator, pick(ambient_sounds), vol = 20, vary = FALSE)

/datum/hallucination/malk/object
	var/static/list/audible_hallucinations = GLOB.derangement_phrases

/datum/hallucination/malk/object/start()
	var/list/objects = list()

	for(var/obj/object in view(hallucinator))
		if((object.invisibility > hallucinator.see_invisible) || !object.loc || !object.name)
			continue
		var/weight = 1
		if(isitem(object))
			weight = 3
		else if(isstructure(object))
			weight = 2
		else if(ismachinery(object))
			weight = 2
		objects[object] = weight
	if(!objects.len)
		return
	objects -= hallucinator.contents

	var/obj/speaker = pick_weight(objects)
	var/speech = pick(audible_hallucinations)
	var/language = hallucinator.get_random_understood_language()
	var/message = hallucinator.compose_message(speaker, language, speech)
	hallucinator.playsound_local(hallucinator, audible_hallucinations[speech], vol = 20, vary = TRUE)
	if(hallucinator.client.prefs.read_preference(/datum/preference/toggle/see_rc_emotes))
		hallucinator.create_chat_message(speaker, language, speech, spans = list(hallucinator.speech_span))
	to_chat(hallucinator, message)

	return TRUE


#undef FLOOR_DISAPPEAR
