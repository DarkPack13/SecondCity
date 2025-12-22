// Base radio type we use for our custom behaviors.
/obj/item/radio/headset/darkpack
	name = "P25 radio"
	desc = "A portable radio headset operating on the P25 digital standard."
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED

// Military Radio
/obj/item/radio/headset/darkpack/military
	name = "military radio"
	radio_network = "Military Network"

/obj/item/radio/headset/darkpack/military/Initialize()
	. = ..()
	set_frequency(FREQ_MILITARY)
	radio_id = rand(1, 999) // Since we wont have a tranceiver for these, we're just auto-assigning a random ID. This isn't foolproof.

// Police Radio get a special button to call for backup.
/obj/item/radio/headset/darkpack/police
	name = "police radio"
	icon_state = "pp25"

/obj/item/radio/headset/darkpack/police/examine(mob/user)
	. = ..()
	. += span_notice("It has a red button on the side to call for backup.")

/obj/item/radio/headset/darkpack/police/interact(mob/user)
	. = ..()
