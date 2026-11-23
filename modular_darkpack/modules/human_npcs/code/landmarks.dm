/obj/effect/landmark/npc_spawn_point
	icon = 'modular_darkpack/modules/deprecated/icons/effects/landmarks_static.dmi'
	icon_state = "spawn"

/obj/effect/landmark/npc_spawn_point/Initialize(mapload)
	. = ..()
	GLOB.npc_spawn_points += src

/obj/effect/landmark/npc_spawn_point/Destroy()
	GLOB.npc_spawn_points -= src
	. = ..()


/obj/effect/landmark/npcbeacon
	name = "NPC landmark"
	icon_state = "x3"

/obj/effect/landmark/npcbeacon/Initialize(mapload)
	. = ..()
	/*
	if(!GLOB.npc_beacons["[z]"])
		GLOB.npc_beacons["[z]"] = list()
	GLOB.npc_beacons["[z]"] += src
	*/
	LAZYADD(GLOB.npc_beacons["[z]"], src)

/obj/effect/landmark/npcbeacon/Destroy()
	glob_lists_deregister()
	. = ..()

/obj/effect/landmark/npcbeacon/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	/*
	if (GLOB.npc_beacons["[old_turf?.z]"])
		GLOB.npc_beacons["[old_turf?.z]"] -= src
	if (GLOB.npc_beacons["[new_turf?.z]"])
		GLOB.npc_beacons["[new_turf?.z]"] += src
	*/
	LAZYREMOVE(GLOB.npc_beacons["[old_turf?.z]"], src)
	LAZYADD(GLOB.npc_beacons["[new_turf?.z]"], src)
	return ..()

/obj/effect/landmark/npcbeacon/proc/glob_lists_deregister()
	LAZYREMOVE(GLOB.npc_beacons["[z]"], src)
	/*
	if(GLOB.npc_beacons["[z]"])
		GLOB.npc_beacons["[z]"] -= src //Remove from beacon list, if in one.
	*/

/obj/effect/landmark/ai_avoid_turf
	name = "AI avoidant turf landmark"
	icon_state = "x"
	can_astar_pass = CANASTARPASS_ALWAYS_PROC

// We want NPCs avoiding crossing these unless they're actively chasing someone.
/obj/effect/landmark/ai_avoid_turf/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	var/mob/living/living_npc = pass_info.requester_ref?.resolve()
	if(!living_npc?.ai_controller?.blackboard[BB_CURRENT_TARGET])
		return FALSE
	return TRUE
