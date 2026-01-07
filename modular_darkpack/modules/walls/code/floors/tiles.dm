/turf/open/floor/city
	abstract_type = /turf/open/floor/city
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'

/turf/open/floor/city/plating
	name = "plating"
	icon_state = "plating"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/city/plating_mono
	name = "plating"
	icon_state = "plating-mono"
	footstep = FOOTSTEP_PLATING

/turf/open/floor/city/plating_stone
	name = "plating"
	icon_state = "plating-stone"

/turf/open/floor/city/toilet
	name = "plating"
	icon_state = "toilet1"

/turf/open/floor/city/toilet/Initialize(mapload)
	. = ..()
	icon_state = "toilet[rand(1, 9)]"

/turf/open/floor/city/toilet/large
	name = "plating"
	icon_state = "toilet_large1"

/turf/open/floor/city/toilet/large/Initialize(mapload)
	. = ..()
	icon_state = "toilet_large[rand(1, 9)]"

/turf/open/floor/city/clinic
	name = "plating"
	icon_state = "clinic1"

/turf/open/floor/city/clinic/Initialize(mapload)
	. = ..()
	icon_state = "clinic[rand(1, 9)]"

/turf/open/floor/city/factory
	name = "plating"
	icon_state = "factory1"

/turf/open/floor/city/factory/Initialize(mapload)
	. = ..()
	icon_state = "factory[rand(1, 9)]"

/turf/open/floor/city/industrial
	name = "plating"
	icon_state = "industrial1"

/turf/open/floor/city/industrial/Initialize(mapload)
	. = ..()
	icon_state = "industrial[rand(1, 9)]"

/turf/open/floor/city/industrial/large
	name = "plating"
	icon_state = "industrial_large1"

/turf/open/floor/city/industrial/large/Initialize(mapload)
	. = ..()
	icon_state = "industrial_large[rand(1, 9)]"

/turf/open/floor/city/circled
	name = "fancy plating"
	icon_state = "circle1"

/turf/open/floor/city/circled/Initialize(mapload)
	. = ..()
	icon_state = "circle[rand(1, 8)]"

/turf/open/floor/city/circled/large
	name = "fancy plating"
	icon_state = "circle_large"

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
	icon_state = "bacotell1"
	base_icon_state = "bacotell"

/turf/open/floor/city/bacotell/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 4)]"

/turf/open/floor/city/gummaguts
	name = "plating"
	icon_state = "gummaguts"
	base_icon_state = "gummaguts"

/turf/open/floor/city/gummaguts/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 4)]"

/turf/open/floor/iron/stairs/black
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "stairs_black"
	base_icon_state = "stairs_black"
	tiled_turf = FALSE

/turf/open/floor/iron/stairs/black/left
	icon_state = "stairs_black-l"
	base_icon_state = "stairs_black-l"

/turf/open/floor/iron/stairs/black/medium
	icon_state = "stairs_black-m"
	base_icon_state = "stairs_black-m"

/turf/open/floor/iron/stairs/black/right
	icon_state = "stairs_black-r"
	base_icon_state = "stairs_black-r"

/turf/open/floor/city/light // TODO: Make this work like code/game/turfs/open/floor/light_floor.dm
	icon_state = "dancefloor"
	base_icon_state = "dancefloor"

/turf/open/floor/iron/stairs/ramp
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "ramp"
	base_icon_state = "ramp"
