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
	density = TRUE
	planetary_atmos = TRUE

/turf/open/umbra/Initialize(mapload)
	. = ..()
	var/obj/minespot/M = locate() in src
	if(M)
		density = FALSE

// This thing is only used in totem creation. Consider just replacing with transfer points as it does not provide any intresting behavoir.
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

/obj/umbra_portal/Initialize(mapload)
	. = ..()
	set_light(2, 1, "#a4a0fb")
	apply_wibbly_filters(src)

	GLOB.umbra_portals += src

	if(id)
		return INITIALIZE_HINT_LATELOAD

/obj/umbra_portal/LateInitialize()
	for(var/obj/umbra_portal/other_portal in GLOB.umbra_portals)
		if(other_portal.id == id)
			link_portal(other_portal)
			break // Im assuming there is no world where this is 3 portals with the same id as that creates unpreticable behavoir.

/obj/umbra_portal/proc/link_portal(obj/umbra_portal/other_portal)
	other_portal.exit = src
	exit = other_portal

/obj/umbra_portal/Destroy()
	. = ..()
	if(exit)
		exit.exit = null
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
