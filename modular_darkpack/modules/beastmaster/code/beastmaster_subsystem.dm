SUBSYSTEM_DEF(beastmastering)
	name = "Beastmastering"
	wait = 10
	priority = FIRE_PRIORITY_NPC

	var/list/currentrun = list()

/datum/controller/subsystem/beastmastering/stat_entry(msg)
	var/list/activelist = GLOB.beast_component_list
	msg = "BEASTS:[length(activelist)]"
	return ..()

/datum/controller/subsystem/beastmastering/fire(resumed = FALSE)

	if (!resumed)
		var/list/activelist = GLOB.beast_component_list
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/datum/component/beastmaster_minion/component = currentrun[currentrun.len]
		--currentrun.len

		if (QDELETED(component))
			GLOB.beast_component_list -= component
			log_world("Found a null in beast component list!")
			continue

		if(MC_TICK_CHECK)
			return

		component.handle_automated_beasting()
