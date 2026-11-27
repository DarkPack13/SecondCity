/datum/bt_node/ai_behavior/human_report_crime
	time_between_perform = 5 SECONDS
	var/criminal_key = BB_WITNESSED_CRIMINAL
	var/crime_witnessed_type_key =

/datum/bt_node/ai_behavior/human_report_crime/perform(seconds_per_tick, datum/ai_controller/controller)
	var/async_flags = handle_async()
	if(async_flags)
		return async_flags

	if(!controller.blackboard_key_exists(criminal_key))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	return start_async()

/datum/bt_node/ai_behavior/human_report_crime/perform_async(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/mob/living/annoyer = astype(controller.blackboard[criminal_key])
	if(annoyer)
		addtimer(CALLBACK(living_pawn, TYPE_PROC_REF(/mob, face_atom), annoyer), rand(0.3 SECONDS, 0.7 SECONDS))

	var/phrase = "Wow."
	var/mob/living/carbon/human/npc/npc_pawn = astype(living_pawn)
	if(npc_pawn)
		phrase = npc_pawn.socialrole?.get_annoyed_phrase(npc_pawn) || phrase

	ADD_TRAIT(living_pawn, TRAIT_THINKING_IN_CHARACTER, REF(src))
	living_pawn.create_typing_indicator()
	var/typing_delay = max(3 SECONDS, round(length_char(phrase) * 0.5))
	sleep(typing_delay)

	if(!async_still_valid())
		return

	living_pawn.remove_typing_indicator()
	REMOVE_TRAIT(living_pawn, TRAIT_THINKING_IN_CHARACTER, REF(src))
	living_pawn.say(phrase, forced = "AI Controller")
	controller.clear_blackboard_key(criminal_key)
	finish_async(AI_BEHAVIOR_SUCCEEDED)
