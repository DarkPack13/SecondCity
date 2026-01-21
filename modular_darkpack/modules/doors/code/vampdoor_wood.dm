/obj/structure/vampdoor/wood // Six paneled plain wooden door
	name = "wooden door"
	icon_state = "wood-1"
	base_icon_state = "wood"
	burnable = TRUE
	// Sounds kinda ass cause its really squeaky
	// open_sound = 'modular_darkpack/modules/doors/sounds/wood_open.ogg'
	// close_sound = 'modular_darkpack/modules/doors/sounds/wood_close.ogg'
	lock_sound = 'modular_darkpack/modules/doors/sounds/wood_locked.ogg'

/obj/structure/vampdoor/wood/apartment
	locked = TRUE
	grant_apartment_key = TRUE
	apartment_key_type = /obj/item/vamp/keys/apartment
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/apartment/Initialize()
	. = ..()
	if(grant_apartment_key && !lock_id)
		lock_id = "[rand(1,9999999)]" // I know, not foolproof
