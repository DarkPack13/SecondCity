///Random speech behavior, for speech thats random
/datum/bt_node/ai_behavior/realistic_speech
	time_between_perform = 1 SECONDS
	/// Chance that the mob will speak.
	var/speech_chance = 1
	/// Var on the social role to pull from
	var/speech_type

/datum/bt_node/ai_behavior/realistic_speech/perform(seconds_per_tick, datum/ai_controller/controller)
	if(HAS_TRAIT_FROM(src, TRAIT_THINKING_IN_CHARACTER, REF(src)))
		return AI_BEHAVIOR_DELAY

	if(!prob(speech_chance))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/mob/living/pawn = controller.pawn
	if(!istype(pawn))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/list/role_phrases = get_reation(controller)

	if(!length(role_phrases))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/phrase = pick(role_phrases)

	INVOKE_ASYNC(src, PROC_REF(speak), pawn, controller, phrase)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/bt_node/ai_behavior/realistic_speech/proc/speak(mob/living/pawn, datum/ai_controller/controller, text)
	pawn.realistic_say(text, source = REF(src))

/datum/bt_node/ai_behavior/realistic_speech/proc/get_reation(datum/ai_controller/controller)
	var/datum/socialrole/my_role

	var/mob/living/carbon/human/npc/pawn = controller.pawn
	if(!istype(pawn))
		return

	my_role = pawn.socialrole
	if(!istype(my_role))
		return
	if(!my_role.vars.Find(speech_type))
		return

	var/phrase = my_role.vars[speech_type]
	if(phrase)
		phrase = my_role.regex_phrase(phrase)

	return phrase
