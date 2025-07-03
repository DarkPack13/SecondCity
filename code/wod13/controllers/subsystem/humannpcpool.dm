SUBSYSTEM_DEF(humannpcpool)
	name = "Human NPC Pool"
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 30

	var/list/currentrun = list()
	var/npc_max = 220

/datum/controller/subsystem/humannpcpool/stat_entry(msg)
	var/list/activelist = GLOB.npc_list
	var/list/living_list = GLOB.alive_npc_list
	msg = "NPCS:[length(activelist)] Living: [length(living_list)]"
	return ..()

/datum/controller/subsystem/humannpcpool/fire(resumed = FALSE)

	if (!resumed)
		var/list/activelist = GLOB.npc_list
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/carbon/human/npc/NPC = currentrun[currentrun.len]
		--currentrun.len

		if (MC_TICK_CHECK)
			return
		NPC.handle_automated_movement()

/datum/controller/subsystem/humannpcpool/proc/npclost()
	if (!length(GLOB.npc_spawn_points))
		return

	while (length(GLOB.alive_npc_list) < npc_max)
		var/atom/chosen_spawn_point = pick(GLOB.npc_spawn_points)
		var/creating_npc = pick(
			/mob/living/carbon/human/npc/police, \
			/mob/living/carbon/human/npc/bandit, \
			/mob/living/carbon/human/npc/hobo, \
			/mob/living/carbon/human/npc/walkby, \
			/mob/living/carbon/human/npc/business \
		)
		new creating_npc(get_turf(chosen_spawn_point))
