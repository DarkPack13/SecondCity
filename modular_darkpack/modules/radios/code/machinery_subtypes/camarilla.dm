// Camarilla Radio Server
/obj/machinery/telecomms/server/presets/camarilla
	id = "Tower Server"
	freq_listening = list(FREQ_CAMARILLA)
	autolinkers = list("camarilla")

/obj/machinery/telecomms/server/presets/camarilla/New()
	. = ..()
	frequency_infos["[FREQ_CAMARILLA]"] = list(
		"name" = RADIO_CHANNEL_CAMARILLA,
		"color" = RADIO_COLOR_CAMARILLA
	)
