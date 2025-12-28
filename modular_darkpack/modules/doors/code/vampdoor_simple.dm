
/obj/structure/vampdoor/simple // Green metal door
	name = "simple door"
	icon_state = "cam-1"
	base_icon_state = "cam"

/obj/structure/vampdoor/simple/camarilla
	locked = TRUE
	lock_id = LOCKACCESS_CAMARILLA
	lockpick_difficulty = 8

/obj/structure/vampdoor/simple/anarch
	locked = TRUE
	lock_id = LOCKACCESS_ANARCH
	lockpick_difficulty = 10

/obj/structure/vampdoor/simple/bar
	locked = TRUE
	lock_id = LOCKACCESS_BAR
	lockpick_difficulty = 10

/obj/structure/vampdoor/simple/supply
	locked = TRUE
	lock_id = LOCKACCESS_SUPPLY
	lockpick_difficulty = 8

/obj/structure/vampdoor/simple/strip
	locked = TRUE
	lock_id = LOCKACCESS_STRIP
	lockpick_difficulty = 4

/obj/structure/vampdoor/simple/dispatch
	locked = TRUE
	lock_id = LOCKACCESS_DISPATCH
	lockpick_difficulty = 5

/obj/structure/vampdoor/simple/police
	locked = TRUE
	lock_id = LOCKACCESS_POLICE
	lockpick_difficulty = 6

/obj/structure/vampdoor/simple/police/secure
	locked = TRUE
	lock_id = LOCKACCESS_POLICE_SECURE
	lockpick_difficulty = 21

/obj/structure/vampdoor/simple/setite
	locked = TRUE
	lock_id = "setite"
	lockpick_difficulty = 10

/obj/structure/vampdoor/simple/food_pantry
	locked = TRUE
	lock_id = "coggie"
	lockpick_difficulty = 4
