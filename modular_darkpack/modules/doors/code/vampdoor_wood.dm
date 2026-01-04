/obj/structure/vampdoor/wood // Six paneled plain wooden door
	name = "wooden door"
	icon_state = "wood-1"
	base_icon_state = "wood"
	burnable = TRUE
	// Sounds kinda ass cause its really squeaky
	// open_sound = 'modular_darkpack/modules/doors/sounds/wood_open.ogg'
	// close_sound = 'modular_darkpack/modules/doors/sounds/wood_close.ogg'
	lock_sound = 'modular_darkpack/modules/doors/sounds/wood_locked.ogg'

/obj/structure/vampdoor/wood/strip
	lock_id = LOCKACCESS_STRIP
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/giovanni
	locked = TRUE
	lock_id = LOCKACCESS_GIOVANNI
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/giovanni/high_security
	lockpick_difficulty = 14

/obj/structure/vampdoor/wood/pentex
	locked = TRUE
	lock_id = LOCKACCESS_PENTEX
	lockpick_difficulty = 16

/obj/structure/vampdoor/wood/madman
	locked = TRUE
	lock_id = "madman"
	lockpick_difficulty = 10

/obj/structure/vampdoor/wood/theatre
	name = "Theatre"
	locked = TRUE
	lock_id = LOCKACCESS_THEATRE
	lockpick_difficulty = 15

/obj/structure/vampdoor/wood/theatre/unlocked
	locked = FALSE

/obj/structure/vampdoor/wood/jazz_club
	name = "Jazz Club"
	lock_id = LOCKACCESS_JAZZ_CLUB
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/daughters
	locked = TRUE
	lock_id = LOCKACCESS_DAUGHTERS
	lockpick_difficulty = 10

/obj/structure/vampdoor/wood/nps
	locked = TRUE
	lock_id = LOCKACCESS_PARK_RANGER
	lockpick_difficulty = 12

/obj/structure/vampdoor/wood/apartment
	locked = TRUE
	grant_apartment_key = TRUE
	apartment_key_type = /obj/item/vamp/keys/apartment
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/apartment/Initialize()
	. = ..()
	if(grant_apartment_key && !lock_id)
		lock_id = "[rand(1,9999999)]" // I know, not foolproof

/obj/structure/vampdoor/wood/millennium_common
	locked = TRUE
	lock_id = LOCKACCESS_JAZZ_CLUB
	lockpick_difficulty = 12

/obj/structure/vampdoor/wood/sabbat
	locked = TRUE
	lock_id = LOCKACCESS_SABBAT
	lockpick_difficulty = 8
