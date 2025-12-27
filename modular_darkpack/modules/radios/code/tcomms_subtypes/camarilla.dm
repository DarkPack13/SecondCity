/obj/machinery/telecomms/server/presets/camarilla
	id = "Tower Server"
	network = "global"
	freq_listening = list(FREQ_CAMARILLA)
	autolinkers = list("camarilla")

/obj/machinery/telecomms/server/presets/camarilla/New()
	. = ..()
	frequency_infos["[FREQ_CAMARILLA]"] = list(
		"name" = RADIO_CHANNEL_CAMARILLA,
		"color" = RADIO_COLOR_CAMARILLA
	)

/obj/machinery/telecomms/bus/darkpack/camarilla
	id = "Tower Bus"
	network = "global"
	freq_listening = list(FREQ_CAMARILLA)
	autolinkers = list("camarilla_processor", "camarilla")

/obj/machinery/telecomms/processor/darkpack/camarilla
	id = "Tower Processor"
	network = "global"
	autolinkers = list("camarilla_processor")
