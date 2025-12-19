// Police Radio
/obj/item/radio/headset/cop
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED
	keyslot = /obj/item/encryptionkey/police

/obj/item/radio/headset/cop/Initialize()
	. = ..()
	set_frequency(FREQ_POLICE)

// Clinic Radio
/obj/item/radio/headset/clinic
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED
	keyslot = /obj/item/encryptionkey/clinic

/obj/item/radio/headset/clinic/Initialize()
	. = ..()
	set_frequency(FREQ_CLINIC)

// Military Radio
/obj/item/radio/headset/military
	name = "military radio"
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED
	keyslot = /obj/item/encryptionkey/military

/obj/item/radio/headset/military/Initialize()
	. = ..()
	set_frequency(FREQ_MILITARY)

// Camarilla Radio
/obj/item/radio/headset/camarilla
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED
	keyslot = /obj/item/encryptionkey/camarilla

/obj/item/radio/headset/camarilla/Initialize()
	. = ..()
	set_frequency(FREQ_CAMARILLA)

// Anarchs Radio
/obj/item/radio/headset/anarch
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED
	keyslot = /obj/item/encryptionkey/anarch

/obj/item/radio/headset/anarch/Initialize()
	. = ..()
	set_frequency(FREQ_ANARCH)
