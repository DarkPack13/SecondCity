/obj/machinery/telecomms/server/presets/police
	id = "Police Server"
	network = "global"
	freq_listening = list(FREQ_POLICE)
	autolinkers = list("police")

/obj/machinery/telecomms/server/presets/police/New()
	. = ..()
	frequency_infos["[FREQ_POLICE]"] = list(
		"name" = RADIO_CHANNEL_POLICE,
		"color" = RADIO_COLOR_POLICE
	)

/obj/machinery/telecomms/bus/darkpack/police
	id = "Police Bus"
	network = "global"
	freq_listening = list(FREQ_POLICE)
	autolinkers = list("police_processor", "police")

/obj/machinery/telecomms/processor/darkpack/police
	id = "Police Processor"
	network = "global"
	autolinkers = list("police_processor")
