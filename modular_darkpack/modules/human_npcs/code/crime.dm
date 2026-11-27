// COMSIG_GLOB_REPORT_CRIME
/mob/living/carbon/human/npc/proc/witness_crime(crime_type, mob/living/victim, mob/living/criminal)

	#warn Set a blackbooard key..

/proc/alert_crime_bystanders(crime_type, mob/living/victim, mob/living/criminal)
	for(var/mob/living/carbon/human/npc/nearby_npc in oviewers(DEFAULT_SIGHT_DISTANCE, victim || criminal))
		nearby_npc.witness_crime(crime_type, victim, criminal)

/datum/crime_report
	var/datum/weakref/crime_location
	var/datum/weakref/criminal
	var/datum/weakref/victim
