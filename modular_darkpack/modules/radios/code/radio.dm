/obj/item/radio/cop
	name = "police radio"
	subspace_transmission = FALSE
	subspace_switchable = FALSE
	keyslot = /obj/item/encryptionkey/headset_sec

/obj/item/radio/cop/Initialize()
	. = ..()
	set_frequency(FREQ_SECURITY)

/obj/item/radio/clinic
	name = "clinic radio"

	keyslot = /obj/item/encryptionkey/headset_med

/obj/item/radio/clinic/Initialize()
	. = ..()
	set_frequency(FREQ_MEDICAL)

/obj/item/radio/military
	name = "military radio"

	//syndie = TRUE
	keyslot = /obj/item/encryptionkey/syndicate

/obj/item/radio/military/Initialize()
	. = ..()
	set_frequency(FREQ_SYNDICATE)
