// COMSIG_GLOB_REPORT_CRIME
/mob/living/carbon/human/npc/proc/witness_crime(datum/crime_report/report)
	if(!ai_controller)
		return
	
	var/chance_to_report = ai_controller.get_npc_attribute(BB_HUMAN_ATTRIBUTE_RESPONSIBILITY)
	if(report.victim?.resolve() == src)	// THATS ME. HELP!!
		chance_to_report += 50

	if(!prob(chance_to_report))
		return

	ai_controller.set_blackboard_key(BB_WITNESSED_CRIME, report)

/proc/alert_crime_bystanders(crime_type, mob/living/victim, mob/living/criminal)
	var/turf/location = get_turf(victim) || get_turf(criminal)
	var/datum/crime_report/crime = new(crime_type, location, criminal, victim)
	for(var/mob/living/carbon/human/npc/nearby_npc in oviewers(DEFAULT_SIGHT_DISTANCE, victim || criminal))
		nearby_npc.witness_crime(crime)


/datum/crime_report
	var/crime_type
	var/datum/weakref/crime_location
	var/datum/weakref/criminal
	var/datum/weakref/victim

/datum/crime_report/New(crime_type, crime_location, criminal, victim)
	. = ..()
	src.crime_type = crime_type
	src.crime_location = WEAKREF(crime_location)
	src.criminal = WEAKREF(criminal)
	src.victim = WEAKREF(victim)
