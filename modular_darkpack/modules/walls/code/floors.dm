/turf/open/floor/plating/concrete
	name = "concrete"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "concrete1"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/concrete/Initialize(mapload)
	. = ..()
	icon_state = "concrete[rand(1, 4)]"

/turf/open/floor/plating/asphalt
	name = "asphalt"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "asphalt1"
	footstep = FOOTSTEP_ASPHALT
	barefootstep = FOOTSTEP_ASPHALT

/turf/open/floor/plating/asphalt/Initialize(mapload)
	. = ..()
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			//initial_gas_mix = WINTER_DEFAULT_ATMOS
			new /obj/effect/decal/snow_overlay(src)
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW
	if(prob(50))
		icon_state = "asphalt[rand(1, 3)]"
	if(prob(25))
		new /obj/effect/turf_decal/asphalt(src)

/turf/open/floor/plating/sidewalkalt
	name = "sidewalk"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "sidewalk_alt"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/sidewalkalt/Initialize(mapload)
	. = ..()
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			//initial_gas_mix = WINTER_DEFAULT_ATMOS
			icon_state = "snow[rand(1, 14)]"
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/sidewalk
	name = "sidewalk"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "sidewalk1"
	var/number_of_variations = 3
	base_icon_state = "sidewalk"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/sidewalk/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, number_of_variations)]"
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			//initial_gas_mix = WINTER_DEFAULT_ATMOS
			icon_state = "snow[rand(1, 14)]"
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/sidewalk/poor
	icon_state = "sidewalk_poor1"
	base_icon_state = "sidewalk_poor"

/turf/open/floor/plating/sidewalk/rich
	icon_state = "sidewalk_rich1"
	number_of_variations = 6
	base_icon_state = "sidewalk_rich"

/turf/open/floor/plating/sidewalk/old
	icon_state = "sidewalk_old1"
	number_of_variations = 4
	base_icon_state = "sidewalk_old"

/turf/open/floor/plating/roofwalk
	name = "roof"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "roof"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/roofwalk/Initialize(mapload)
	. = ..()
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			//initial_gas_mix = WINTER_DEFAULT_ATMOS
			icon_state = "snow[rand(1, 14)]"
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW

//Airless version of this because they are used as a z-level 4 roof on a z-level 3 building, and since they aren't meant to be reached...
/turf/open/floor/plating/roofwalk/no_air
	blocks_air = 1

/turf/open/floor/plating/roofwalk/cobblestones
	name = "cobblestones"

//OTHER TURFS

/turf/open/floor/plating/granite
	name = "granite"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "granite"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/granite/black
	icon_state = "granite-black"

/turf/open/floor/plating/rough
	name = "rough floor"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "rough"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/rough/cave
	icon_state = "cave1"

/turf/open/floor/plating/rough/cave/Initialize(mapload)
	. = ..()
	icon_state = "cave[rand(1, 7)]"

/turf/open/floor/plating/stone
	name = "rough floor"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "stone"
	footstep = FOOTSTEP_SIDEWALK
	barefootstep = FOOTSTEP_SIDEWALK

/turf/open/floor/plating/stone
	icon_state = "stone1"

/turf/open/floor/plating/stone/Initialize(mapload)
	. = ..()
	icon_state = "cave[rand(1, 7)]"

/turf/open/floor/plating/grate
	name = "grate"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "lattice_new"
	footstep = FOOTSTEP_CATWALK

/turf/open/floor/plating/grate/dirty
	icon_state = "lattice_new_dirt"

/turf/open/misc/grass/random
	WHEN_MAP(icon = 'modular_darkpack/modules/walls/icons/floors.dmi')
	WHEN_MAP(icon_state = "grass_autodec_all")
	var/autodecor = /obj/effect/spawner/random/flora/all

/turf/open/misc/grass/random/grass
	WHEN_MAP(icon_state = "grass_autodec_grass")
	autodecor = /obj/effect/spawner/random/flora/grass

/turf/open/misc/grass/random/bushes
	WHEN_MAP(icon_state = "grass_autodec_bushes")
	autodecor = /obj/effect/spawner/random/flora/bushes

/turf/open/misc/grass/random/rocks
	WHEN_MAP(icon_state = "grass_autodec_rocks")
	autodecor = /obj/effect/spawner/random/flora/rocks

/turf/open/misc/grass/random/Initialize(mapload)
	. = ..()
	if(prob(33))
		new autodecor(src)

/turf/open/misc/dirt/Initialize(mapload)
	. = ..()
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			//initial_gas_mix = WINTER_DEFAULT_ATMOS
			icon_state = "snow[rand(1, 14)]"
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW

/turf/open/misc/dirt/rails
	name = "rails"
	icon_state = "dirt_rails"

/turf/open/misc/dirt/rails/Initialize(mapload)
	. = ..()
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			//initial_gas_mix = WINTER_DEFAULT_ATMOS
			icon_state = "snow_rails"
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW

/turf/open/misc/beach/vamp
	name = "sand"
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "sand1"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	baseturfs = /turf/open/misc/beach/vamp
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/vamp/Initialize(mapload)
	. = ..()
	icon_state = "sand[rand(1, 4)]"
	var/area/my_area = loc
	if(my_area.outdoors)
		if(check_holidays(FESTIVE_SEASON))
			icon_state = "snow[rand(1, 14)]"
			footstep = FOOTSTEP_SNOW
			barefootstep = FOOTSTEP_SNOW
			heavyfootstep = FOOTSTEP_SNOW

/turf/closed/indestructible/elevatorshaft
	name = "elevator shaft"
	desc = "Floors, floors, floors..."
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "black"
