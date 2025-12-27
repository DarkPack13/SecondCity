/obj/structure/vampdoor/glass // Blue door with dual glass panels
	name = "glass door"
	icon_state = "glass_blue-1"
	opacity = FALSE
	base_icon_state = "glass_blue"

/obj/structure/vampdoor/glass/clerk
	lock_id = LOCKACCESS_CLERK
	lockpick_difficulty = 12
	locked = TRUE

/obj/structure/vampdoor/glass/banu_haqim
	lock_id = LOCKACCESS_BANU
	locked = TRUE

/obj/structure/vampdoor/glass/bianchi_bank
	name = "bianchi executive office door"
	lock_id = LOCKACCESS_BANKBOSS
	lockpick_difficulty = 23
	locked = TRUE

/obj/structure/vampdoor/glass/clinic
	locked = TRUE
	lock_id = LOCKACCESS_CLINIC
	lockpick_difficulty = 4

/obj/structure/vampdoor/glass/clinic/high_security
	lockpick_difficulty = 16

/obj/structure/vampdoor/glass/laundromat
	name = "Laundromat"
	lock_id = LOCKACCESS_LAUNDROMAT
	lockpick_difficulty = 7

/obj/structure/vampdoor/glass/nightwolf
	name = "Nightwolf Tech"
	lock_id = LOCKACCESS_WOLFTECH
	lockpick_difficulty = 12

/obj/structure/vampdoor/glass/pentex
	lock_id = LOCKACCESS_PENTEX
	lockpick_difficulty = 12
	locked = TRUE

/obj/structure/vampdoor/glass/pentex/low_security
	lockpick_difficulty = 4

/obj/structure/vampdoor/glass/pentex/low_security/unlocked
	locked = FALSE

/obj/structure/vampdoor/glass/primogen_toreador
	lock_id = LOCKACCESS_PRIMOGEN_TOREADOR
	lockpick_difficulty = 14

/obj/structure/vampdoor/glass/police_chief
	locked = TRUE
	lock_id = LOCKACCESS_POLICE_CHIEF
	lockpick_difficulty = 21

/obj/structure/vampdoor/glass/jazz_club
	name = "Jazz Club"
	lock_id = LOCKACCESS_JAZZ_CLUB
	lockpick_difficulty = 8
