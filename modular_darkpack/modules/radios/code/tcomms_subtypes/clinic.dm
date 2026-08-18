/obj/machinery/telecomms/server/presets/clinic
	id = "Clinic Server"
	network = "global"
	freq_listening = list(FREQ_CLINIC)
	autolinkers = list("clinic")

/obj/machinery/telecomms/server/presets/clinic/New()
	. = ..()
	frequency_infos["[FREQ_CLINIC]"] = list(
		"name" = RADIO_CHANNEL_CLINIC,
		"color" = RADIO_COLOR_CLINIC
	)

/obj/machinery/telecomms/bus/darkpack/clinic
	id = "Clinic Bus"
	network = "global"
	freq_listening = list(FREQ_CLINIC)
	autolinkers = list("clinic_processor", "clinic")

/obj/machinery/telecomms/processor/darkpack/clinic
	id = "Clinic Processor"
	network = "global"
	autolinkers = list("clinic_processor")
