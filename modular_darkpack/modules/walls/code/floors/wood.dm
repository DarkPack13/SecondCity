// dwinters99 (carpenter) consulted for wood type paths

// consider just fully removing these, it overlaps with FOOTSTEP_WOOD very hard
// and FOOTSTEP_WOOD sounds better imo
//	footstep = FOOTSTEP_PARKET
//	barefootstep = FOOTSTEP_PARKET

/turf/open/floor/wood/rough
	name = "wood flooring"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "wood1"
	base_icon_state = "wood"
	floor_tile = null

/turf/open/floor/wood/rough/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 12)]"

/turf/open/floor/wood/herring
	name = "fancy wood flooring"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "woodd1"
	base_icon_state = "woodd"
	floor_tile = null

/turf/open/floor/wood/herring/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 12)]"

/turf/open/floor/wood/old
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "wood_old"
	floor_tile = null

/turf/open/floor/wood/smooth
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "wood_smooth"
	floor_tile = null

/turf/open/floor/wood/smooth/old
	icon_state = "wood_smooth_old"

/turf/open/floor/wood/ornate
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "wood_ornate"
	floor_tile = null
