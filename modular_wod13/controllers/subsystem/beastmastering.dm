SUBSYSTEM_DEF(beastmastering)
	name = "Beastmastering"
	init_order = INIT_ORDER_DEFAULT
	wait = 10
	priority = FIRE_PRIORITY_NPC

	var/list/currentrun = list()

/datum/controller/subsystem/beastmastering/stat_entry(msg)
	var/list/activelist = GLOB.beast_list
	msg = "BEASTS:[length(activelist)]"
	return ..()

/datum/controller/subsystem/beastmastering/fire(resumed = FALSE)

	if (!resumed)
		var/list/activelist = GLOB.beast_list
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/simple_animal/hostile/beastmaster/NPC = currentrun[currentrun.len]
		--currentrun.len

		if (QDELETED(NPC)) // Some issue causes nulls to get into this list some times. This keeps it running, but the bug is still there.
			GLOB.npc_list -= NPC
			GLOB.alive_npc_list -= NPC
			log_world("Found a null in npc list!")
			continue

		//NPC.observed_by_player()
		if(MC_TICK_CHECK)
			return
		NPC.handle_automated_beasting()
