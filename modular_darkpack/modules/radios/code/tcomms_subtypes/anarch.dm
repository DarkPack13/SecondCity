/obj/machinery/telecomms/server/presets/anarch
	id = "Bar Server"
	network = "global"
	freq_listening = list(FREQ_ANARCH)
	autolinkers = list("anarch")

/obj/machinery/telecomms/server/presets/anarch/New()
	. = ..()
	frequency_infos["[FREQ_ANARCH]"] = list(
		"name" = RADIO_CHANNEL_ANARCH,
		"color" = RADIO_COLOR_ANARCH
	)

/obj/machinery/telecomms/bus/darkpack/anarch
	id = "Bar Bus"
	network = "global"
	freq_listening = list(FREQ_ANARCH)
	autolinkers = list("anarch_processor", "anarch")

/obj/machinery/telecomms/processor/darkpack/anarch
	id = "Bar Processor"
	network = "global"
	autolinkers = list("anarch_processor")
