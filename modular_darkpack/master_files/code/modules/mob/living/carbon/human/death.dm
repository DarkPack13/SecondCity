/mob/living/carbon/human/death(gibbed)
	. = ..()
	if(!.)
		return .

	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_MURDER, get_turf(src))
	GLOB.masquerade_breakers_list -= src
	GLOB.sabbatites -= src

	last_death_info = new()
	last_death_info.record_death(src)


// Not an override. Usecases will be spread out across modules so it goes here.
/datum/death_report
	var/area
	var/last_words
	var/last_attacker_name
	var/suicide

/datum/death_report/proc/record_death(mob/living/carbon/human/dead_guy)
	area = get_area(dead_guy)
	last_attacker_name = dead_guy.lastattacker
	last_words = dead_guy.last_words
	suicide = HAS_TRAIT(dead_guy, TRAIT_SUICIDED)
