/obj/structure/vampdoor/old // Blue utility door with a vent. // TODO: Atmos passthrough var for when/if atmos is implemented
	name = "old door"
	icon_state = "old-1"
	base_icon_state = "old"

/obj/structure/vampdoor/old/chantry
	locked = TRUE
	lock_id = LOCKACCESS_CHANTRY
	lockpick_difficulty = 10

/obj/structure/vampdoor/old/graveyard
	locked = TRUE
	lock_id = LOCKACCESS_GRAVEYARD
	lockpick_difficulty = 2

/obj/structure/vampdoor/old/church
	locked = TRUE
	lock_id = LOCKACCESS_CHURCH
	lockpick_difficulty = 10
