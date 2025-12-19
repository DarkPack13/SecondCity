// Base radio type we use for our custom behaviors.
/obj/item/radio/headset/darkpack
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED
	var/radio_id

/obj/item/radio/headset/darkpack/click_alt(mob/living/user)
	if(!radio_id)
		radio_id = tgui_input_number(user = user, message = "Set Radio ID", title = "Enter a numeric ID for this radio:", max_value = 999, min_value = 1, round_value = TRUE)
	return ..()

/obj/item/radio/headset/darkpack/examine(mob/user)
	. = ..()
	if(!radio_id)
		. += span_notice("It has no ID set.")
	else
		. += span_notice("The Radio ID is set to [radio_id].")

// Police Radio
/obj/item/radio/headset/darkpack/cop
	keyslot = /obj/item/encryptionkey/police

/obj/item/radio/headset/darkpack/cop/Initialize()
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

/obj/item/radio/headset/darkpack/military/Initialize()
	. = ..()
	set_frequency(FREQ_MILITARY)

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
