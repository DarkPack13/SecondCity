SUBSYSTEM_DEF(wanted_level)
	name = "Wanted Level"
	flags = SS_NO_INIT|SS_NO_FIRE

/datum/controller/subsystem/wanted_level/proc/announce_crime(crime_type = "unknown", atom/location, requires_witness = FALSE)
	if(requires_witness)
		var/witness_count = 0
		for(var/mob/living/carbon/human/npc/npc_around in viewers(DEFAULT_SIGHT_DISTANCE, location))
			if(npc_around.stat != DEAD)
				witness_count++
		if(witness_count <= 0)
			return

	for(var/obj/item/police_radio/radio in GLOB.police_radios)
		radio.announce_crime(crime_type, location)
	// TODO: [Rebase] - RADIOS
	/*
	for(var/obj/machinery/p25transceiver/police/transceiver in GLOB.p25_transceivers)
		if(transceiver.p25_network == "police")
			transceiver.announce_crime(crime_type, location)
			break
	*/

