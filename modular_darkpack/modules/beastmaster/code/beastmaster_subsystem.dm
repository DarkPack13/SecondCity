SUBSYSTEM_DEF(beastmastering)
	name = "Beastmastering"
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
		var/mob/living/simple_animal/hostile/beastmaster/beast = currentrun[currentrun.len]
		--currentrun.len

		if (QDELETED(beast))
			GLOB.beast_list -= beast
			log_world("Found a null in beast list!")
			continue

		if(MC_TICK_CHECK)
			return
		beast.handle_automated_beasting()
