/datum/bt_node/ai_behavior/human_report_crime
	time_between_perform = 5 SECONDS
	var/crime_key = BB_WITNESSED_CRIME


/datum/bt_node/ai_behavior/human_report_crime/perform(seconds_per_tick, datum/ai_controller/controller)
	var/async_flags = handle_async()
	if(async_flags)
		return async_flags

	if(!controller.blackboard_key_exists(crime_key))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	return start_async()

/datum/bt_node/ai_behavior/human_report_crime/perform_async(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/datum/crime_report/crime = controller.blackboard[crime_key]
