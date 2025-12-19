// Anarch Radio Server
/obj/machinery/telecomms/server/presets/anarch
	id = "Bar Server"
	freq_listening = list(FREQ_ANARCH)
	autolinkers = list("anarch")

/obj/machinery/telecomms/server/presets/anarch/New()
	. = ..()
	frequency_infos["[FREQ_ANARCH]"] = list(
		"name" = RADIO_CHANNEL_ANARCH,
		"color" = RADIO_COLOR_ANARCH
	)
