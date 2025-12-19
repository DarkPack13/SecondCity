// Base radio type we use for our custom behaviors.
/obj/item/radio/headset/darkpack
	name = "P25 radio"
	desc = "A portable radio headset operating on the P25 digital standard."
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED
	var/radio_network
	var/radio_id

/obj/item/radio/headset/darkpack/examine(mob/user)
	. = ..()
	. += radio_network ? span_notice("Connected to [radio_network] using ID: [radio_id].") : span_warning("Not connected to any network.")

// Police Radio
/obj/item/radio/headset/darkpack/police
	keyslot = /obj/item/encryptionkey/police

/obj/item/radio/headset/darkpack/police/Initialize()
	. = ..()
	set_frequency(FREQ_POLICE)

// Clinic Radio
/obj/item/radio/headset/darkpack/clinic
	keyslot = /obj/item/encryptionkey/clinic

/obj/item/radio/headset/darkpack/clinic/Initialize()
	. = ..()
	set_frequency(FREQ_CLINIC)

// Military Radio
/obj/item/radio/headset/darkpack/military
	name = "military radio"
	keyslot = /obj/item/encryptionkey/military
	radio_network = "Military Network"

/obj/item/radio/headset/darkpack/military/Initialize()
	. = ..()
	set_frequency(FREQ_MILITARY)
	radio_id = rand(1, 999) // Since we wont have a tranceiver for these, we're just auto-assigning a random ID. This isn't foolproof.

// Camarilla Radio
/obj/item/radio/headset/darkpack/camarilla
	keyslot = /obj/item/encryptionkey/camarilla

/obj/item/radio/headset/darkpack/camarilla/Initialize()
	. = ..()
	set_frequency(FREQ_CAMARILLA)

// Anarchs Radio
/obj/item/radio/headset/darkpack/anarch
	keyslot = /obj/item/encryptionkey/anarch

/obj/item/radio/headset/darkpack/anarch/Initialize()
	. = ..()
	set_frequency(FREQ_ANARCH)
