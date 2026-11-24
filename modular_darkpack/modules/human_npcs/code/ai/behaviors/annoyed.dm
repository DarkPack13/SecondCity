/datum/bt_node/ai_behavior/human_react_annoyed
	time_between_perform = 5 SECONDS
	var/annoyer_key

	COOLDOWN_DECLARE(annoyed_cooldown)

/datum/bt_node/ai_behavior/human_react_annoyed/perform(seconds_per_tick, datum/ai_controller/controller)
	var/async_flags = handle_async()
	if(async_flags)
		return async_flags

	var/mob/living/living_pawn = pawn

	if (!COOLDOWN_FINISHED(src, annoyed_cooldown))
		return AI_BEHAVIOR_FAILED
	COOLDOWN_START(src, annoyed_cooldown, 5 SECONDS)

	GLOB.move_manager.stop_looping(living_pawn)


	if(annoyer)
		addtimer(CALLBACK(living_pawn, TYPE_PROC_REF(/mob, face_atom), annoyer), rand(0.3 SECONDS, 0.7 SECONDS))

	var/mob/living/carbon/human/npc/npc_pawn = astype(pawn)
	if(npc_pawn)
		var/phrase = npc_pawn.socialrole?.get_annoyed_phrase(npc_pawn) || "Wow."
		npc_pawn.realistic_say(phrase)

	change_npc_reputation(annoyer, -5)
