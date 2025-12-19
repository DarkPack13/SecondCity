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
