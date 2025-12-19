// Police Radio Server
/obj/machinery/telecomms/server/presets/police
	id = "Police Server"
	freq_listening = list(FREQ_POLICE)
	autolinkers = list("police")

/obj/machinery/telecomms/server/presets/police/New()
	. = ..()
	frequency_infos["[FREQ_POLICE]"] = list(
		"name" = RADIO_CHANNEL_POLICE,
		"color" = RADIO_COLOR_POLICE
	)
