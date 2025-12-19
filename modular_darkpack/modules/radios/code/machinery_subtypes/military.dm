// Military Radio Server
/obj/machinery/telecomms/server/presets/military
	id = "Military Server"
	freq_listening = list(FREQ_MILITARY)
	autolinkers = list("military")

/obj/machinery/telecomms/server/presets/military/New()
	. = ..()
	frequency_infos["[FREQ_MILITARY]"] = list(
		"name" = RADIO_CHANNEL_MILITARY,
		"color" = RADIO_COLOR_MILITARY
	)
