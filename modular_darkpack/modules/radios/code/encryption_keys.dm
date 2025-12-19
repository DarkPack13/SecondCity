/obj/item/encryptionkey/police
	name = "police encryption key"
	desc = "An encryption key used to access police radio frequencies."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_service"
	post_init_icon_state = "cypherkey_service"
	channels = list(RADIO_CHANNEL_POLICE = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_service
	greyscale_colors = "#820a16#280b1a"

/obj/item/encryptionkey/clinic
	name = "clinic encryption key"
	desc = "An encryption key used to access clinic radio frequencies."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_med"
	post_init_icon_state = "cypherkey_medical"
	channels = list(RADIO_CHANNEL_CLINIC = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#820a16#280b1a"

/obj/item/encryptionkey/military
	name = "military encryption key"
	desc = "An encryption key used to access military radio frequencies."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/syndicate"
	post_init_icon_state = "cypherkey_syndicate"
	channels = list(RADIO_CHANNEL_MILITARY = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_syndicate
	greyscale_colors = "#820a16#280b1a"

/obj/item/encryptionkey/camarilla
	name = "camarilla encryption key"
	desc = "An encryption key used to access millennium tower radio frequencies."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_mining"
	post_init_icon_state = "cypherkey_cargo"
	channels = list(RADIO_CHANNEL_CAMARILLA = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_cargo
	greyscale_colors = "#820a16#280b1a"

/obj/item/encryptionkey/anarch
	name = "anarch encryption key"
	desc = "An encryption key used to access bar radio frequencies."
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_sec"
	post_init_icon_state = "cypherkey_security"
	channels = list(RADIO_CHANNEL_ANARCH = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_security
	greyscale_colors = "#820a16#280b1a"
