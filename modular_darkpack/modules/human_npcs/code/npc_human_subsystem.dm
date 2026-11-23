SUBSYSTEM_DEF(humannpcpool)
	name = "Human NPC Pool"
	ss_flags = SS_BACKGROUND|SS_NO_FIRE
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME
	wait = 5 SECONDS

	dependencies = list(
		/datum/controller/subsystem/mapping,
		/datum/controller/subsystem/atoms,
	)

/datum/controller/subsystem/humannpcpool/Initialize()
	try_repopulate()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/humannpcpool/stat_entry(msg)
	msg = "NPCS:[length(GLOB.human_npc_list)] Living: [length(GLOB.alive_human_npc_list)]"
	return ..()


/datum/controller/subsystem/humannpcpool/fire(resumed)
	. = ..()
	try_repopulate()

/datum/controller/subsystem/humannpcpool/proc/try_repopulate()
	if(!length(GLOB.npc_spawn_points))
		return

	while(length(GLOB.alive_human_npc_list) < SSmapping.current_map.max_npcs)
		var/atom/chosen_spawn_point = pick(GLOB.npc_spawn_points)
		var/creating_npc = pick(
			/mob/living/carbon/human/npc/poor,
			/mob/living/carbon/human/npc/average,
			/mob/living/carbon/human/npc/rich,
			/mob/living/carbon/human/npc/police,
			/mob/living/carbon/human/npc/bandit,
		)
		new creating_npc(get_turf(chosen_spawn_point))
