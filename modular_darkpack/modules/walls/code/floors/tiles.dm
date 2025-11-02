/turf/open/floor/carpet/darkpack
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "carpet_black"
	smoothing_flags = NONE
	floor_tile = null

/turf/open/floor/city
	abstract_type = /turf/open/floor/city
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'

/turf/open/floor/city/plating
	name = "plating"
	icon_state = "plating"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/city/plating/mono
	icon_state = "plating-mono"

/turf/open/floor/city/plating/stone
	icon_state = "plating-stone"

/turf/open/floor/city/toilet
	name = "plating"
	icon_state = "toilet1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/city/toilet/Initialize(mapload)
	. = ..()
	icon_state = "toilet[rand(1, 9)]"

/turf/open/floor/city/industrial
	name = "plating"
	icon_state = "industrial1"

/turf/open/floor/city/industrial/Initialize(mapload)
	. = ..()
	icon_state = "industrial[rand(1, 9)]"

/turf/open/floor/city/circled
	name = "fancy plating"
	icon_state = "circle1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/city/circled/Initialize(mapload)
	. = ..()
	icon_state = "circle[rand(1, 8)]"

/turf/open/floor/city/church
	name = "fancy plating"
	icon_state = "church1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/city/church/Initialize(mapload)
	. = ..()
	icon_state = "church[rand(1, 4)]"

/turf/open/floor/city/saint
	name = "fancy plating"
	icon_state = "saint1"
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/city/saint/Initialize(mapload)
	. = ..()
	icon_state = "saint[rand(1, 2)]"

/turf/open/floor/city/bacotell
	name = "plating"
	icon_state = "bacotell"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/city/gummaguts
	name = "plating"
	icon_state = "gummaguts"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK
