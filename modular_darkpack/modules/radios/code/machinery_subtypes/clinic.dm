// Clinic Radio Server
/obj/machinery/telecomms/server/presets/clinic
	id = "Clinic Server"
	freq_listening = list(FREQ_CLINIC)
	autolinkers = list("clinic")

/obj/machinery/telecomms/server/presets/clinic/New()
	. = ..()
	frequency_infos["[FREQ_CLINIC]"] = list(
		"name" = RADIO_CHANNEL_CLINIC,
		"color" = RADIO_COLOR_CLINIC
	)
