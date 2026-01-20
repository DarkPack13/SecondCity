/obj/structure/vampdoor/reinf // Blue three-paneled door
	name = "reinforced door"
	icon_state = "reinf-1"
	base_icon_state = "reinf"
	bash_difficulty = 8
	bash_successes_needed = 3

/obj/structure/vampdoor/reinf/cleaning
	locked = TRUE
	lock_id = LOCKACCESS_CLEANING
	lockpick_difficulty = 4

/obj/structure/vampdoor/reinf/setite_high_sec
	locked = TRUE
	lock_id = "setite"
	lockpick_difficulty = 15
