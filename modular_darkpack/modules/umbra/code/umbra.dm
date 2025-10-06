/turf/open/umbra
	gender = PLURAL
	name = "nothing"
	icon_state = "black"
	footstep = FOOTSTEP_SNOW
	barefootstep = FOOTSTEP_SNOW
	heavyfootstep = FOOTSTEP_SNOW
	plane = PLANE_SPACE
	layer = SPACE_LAYER
	light_power = 0.25
	//dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	umbra = TRUE
	density = TRUE
	planetary_atmos = TRUE

/turf/open/umbra/Initialize(mapload)
	. = ..()
	var/obj/minespot/M = locate() in src
	if(M)
		density = FALSE

/obj/umbra_portal
	name = "gateway"
	desc = "Step to the other side."
	icon = 'modular_darkpack/modules/deprecated/icons/48x48.dmi'
	icon_state = "portal"
	density = TRUE
	anchored = TRUE
	plane = ABOVE_LIGHTING_PLANE
	//layer = ABOVE_LIGHTING_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_w = -8
	var/obj/umbra_portal/exit
	var/id

/obj/umbra_portal/proc/later_Initialize(mapload)
	set_light(2, 1, "#a4a0fb")
	if(id)
		for(var/obj/umbra_portal/U in GLOB.umbra_portals)
			if(U.id)
				if(U.id == id)
					U.exit = src
					exit = U
		GLOB.umbra_portals += src

/obj/umbra_portal/Destroy()
	. = ..()
	if(id)
		for(var/obj/umbra_portal/U in GLOB.umbra_portals)
			if(U.id)
				if(U.id == id)
					U.exit = null
					exit = null
		GLOB.umbra_portals -= src

/obj/umbra_portal/Bumped(atom/movable/AM)
	. = ..()
	if (istype(AM, /mob/living/carbon))
		var/mob/living/carbon/interacting_mob = AM
		if (interacting_mob.client)
			var/turf/T = get_step(exit, get_dir(interacting_mob, src))
			interacting_mob.forceMove(T)
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/portal_enter.ogg', 75, FALSE)
			playsound(T, 'modular_darkpack/modules/deprecated/sounds/portal_enter.ogg', 75, FALSE)
