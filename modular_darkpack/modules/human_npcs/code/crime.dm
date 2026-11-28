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
	var/creation_time
	/// If an NPC reports this, what clothing they saw.
	var/clothing_desc

/datum/crime_report/New(crime_type, crime_location, criminal, victim)
	. = ..()
	src.crime_type = crime_type
	src.crime_location = WEAKREF(crime_location)
	src.criminal = WEAKREF(criminal)
	src.victim = WEAKREF(victim)

	creation_time = world.time

/datum/crime_report/Topic(href, href_list)
	if(href_list["navigate_to"])
		var/mob/living/carbon/human/clicker = astype(usr)
		if(!clicker)
			return
		if(HAS_TRAIT(clicker, TRAIT_INCAPACITATED))
			return
		if(!length(clicker.get_all_contents_type(/obj/item/radio/headset/darkpack/police)))
			to_chat(clicker, span_notice("You need a police radio!"))
			return
		var/turf/tracking_location = crime_location?.resolve()
		if(!tracking_location)
			return
		clicker.create_navigation_line(tracking_location)
	return ..()
