/mob/living/carbon/human/death(gibbed)
	. = ..()
	if(!.)
		return .

	GLOB.masquerade_breakers_list -= src
	GLOB.sabbatites -= src
	var/witness_to_report = 0
	for(var/mob/living/carbon/human/npc/witness in viewers(7, usr))	//Sends report if there is a witness to the murder.
		if(witness && witness.stat != DEAD)
			witness_to_report++
		if(witness_to_report >= 1)	//Wait to send, only one caller
			SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_MURDER, get_turf(src))
			break

	//Sends report of murder if in designated area that would, normally, have a camera in it & not super-natural run.
	for(var/area/A as anything in list(/area/vtm/interior/shop, /area/vtm/interior/police, /area/vtm/interior/police/upstairs, /area/vtm/interior/police/court))
		//do_after(3 SECONDS)	//Delayed send, security cameras will take a moment
		SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_MURDER, get_turf(src))
