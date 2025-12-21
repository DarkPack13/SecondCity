/obj/machinery/telecomms/hub/darkpack
	id = "Communications Hub"
	network = "global"
	autolinkers = list(
		"relay",
		"receiver",
		"broadcaster",
		"police",
	)

/obj/machinery/telecomms/receiver/darkpack
	id = "Communications Receiver"
	network = "global"
	autolinkers = list("receiver")
	freq_listening = list(FREQ_POLICE)

/obj/machinery/telecomms/broadcaster/darkpack
	id = "Communications Broadcaster"
	network = "global"
	autolinkers = list("broadcaster")

/obj/machinery/telecomms/relay/darkpack
	id = "Communications Relay"
	network = "global"
	autolinkers = list("relay")
