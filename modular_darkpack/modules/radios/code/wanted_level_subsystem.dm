SUBSYSTEM_DEF(wanted_level)
	name = "Wanted Level"
	flags = SS_NO_INIT|SS_NO_FIRE

/datum/controller/subsystem/wanted_level/proc/announce_crime(crime_type = "unknown", atom/location, requires_witness = FALSE)
	return
	// TODO: [Rebase] - RADIOS
	/*
	for(var/obj/item/police_radio/radio in GLOB.police_radios)
		radio.announce_crime(crime_type, location)
	for(var/obj/machinery/p25transceiver/police/transceiver in GLOB.p25_transceivers)
		if(transceiver.p25_network == "police")
			transceiver.announce_crime(crime_type, location)
			break
	*/

