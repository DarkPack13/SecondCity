/obj/structure/vampdoor/wood // Six paneled plain wooden door
	name = "wooden door"
	icon_state = "wood-1"
	base_icon_state = "wood"
	burnable = TRUE
	open_sound = 'modular_darkpack/modules/doors/sounds/wood_open.ogg'
	close_sound = 'modular_darkpack/modules/doors/sounds/wood_close.ogg'
	lock_sound = 'modular_darkpack/modules/doors/sounds/wood_locked.ogg'

/obj/structure/vampdoor/wood/strip
	lock_id = "strip"
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/giovanni
	locked = TRUE
	lock_id = "giovanni"
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/giovanni/high_security
	lockpick_difficulty = 14

/obj/structure/vampdoor/wood/pentex
	locked = TRUE
	lock_id = "pentex"
	lockpick_difficulty = 16

/obj/structure/vampdoor/wood/madman
	locked = TRUE
	lock_id = "madman"
	lockpick_difficulty = 10

/obj/structure/vampdoor/wood/theatre
	name = "Theatre"
	locked = TRUE
	lock_id = "theatre"
	lockpick_difficulty = 15

/obj/structure/vampdoor/wood/theatre/unlocked
	locked = FALSE

/obj/structure/vampdoor/wood/jazz_club
	name = "Jazz Club"
	lock_id = "milleniumCommon"
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/daughters
	locked = TRUE
	lock_id = "daughters"
	lockpick_difficulty = 10
