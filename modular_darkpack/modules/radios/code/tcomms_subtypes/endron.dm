/obj/machinery/telecomms/server/presets/endron
	id = "Endron Server"
	network = "endron"
	freq_listening = list(FREQ_ENDRON)
	autolinkers = list("endron")

/obj/machinery/telecomms/server/presets/endron/New()
	. = ..()
	frequency_infos["[FREQ_ENDRON]"] = list(
		"name" = RADIO_CHANNEL_ENDRON,
		"color" = RADIO_COLOR_ENDRON
	)

/obj/machinery/telecomms/bus/darkpack/endron
	id = "Endron Bus"
	network = "endron"
	freq_listening = list(FREQ_ENDRON)
	autolinkers = list("endron_processor", "endron")

/obj/machinery/telecomms/processor/darkpack/endron
	id = "Endron Processor"
	network = "endron"
	autolinkers = list("endron_processor")

/obj/machinery/telecomms/receiver/darkpack/endron
	id = "Endron Communications Receiver"
	network = "endron"
	autolinkers = list("endron_receiver")

/obj/machinery/telecomms/broadcaster/darkpack/endron
	id = "Endron Communications Broadcaster"
	network = "endron"
	autolinkers = list("endron_broadcaster")

/obj/machinery/telecomms/relay/darkpack/endron
	id = "Endron Communications Relay"
	network = "endron"
	autolinkers = list("endron_relay")

/obj/machinery/telecomms/hub/darkpack/endron
	id = "Communications Hub"
	network = "global"
	autolinkers = list(
		"endron_relay",
		"endron_receiver",
		"endron_broadcaster",
		"endron",
	)
