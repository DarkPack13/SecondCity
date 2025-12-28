/obj/structure/vampdoor/oldwood // Six paneled wooden door with peeling green paint
	name = "old wooden door"
	icon_state = "oldwood-1"
	base_icon_state = "oldwood"
	burnable = TRUE
	// open_sound = 'modular_darkpack/modules/doors/sounds/wood_open.ogg'
	// close_sound = 'modular_darkpack/modules/doors/sounds/wood_close.ogg'
	lock_sound = 'modular_darkpack/modules/doors/sounds/wood_locked.ogg'

/obj/structure/vampdoor/oldwood/chantry
	lock_id = LOCKACCESS_CHANTRY
	lockpick_difficulty = 12
	locked = TRUE

/obj/structure/vampdoor/oldwood/baali
	locked = TRUE
	lock_id = LOCKACCESS_BAALI
	lockpick_difficulty = 8

/obj/structure/vampdoor/oldwood/salubri
	locked = TRUE
	lock_id = LOCKACCESS_SALUBRI
	lockpick_difficulty = 8

/obj/structure/vampdoor/oldwood/clan_tzimisce
	locked = TRUE
	lock_id = LOCKACCESS_OLD_CLAN_TZI
	lockpick_difficulty = 8

/obj/structure/vampdoor/oldwood/children_of_gaia
	locked = TRUE
	lock_id = "coggie"
	lockpick_difficulty = 10

