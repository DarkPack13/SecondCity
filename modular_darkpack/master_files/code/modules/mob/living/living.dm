/mob/living
	COOLDOWN_DECLARE(masquerade_timer)
	//thaumaturgy & necro path stuff
	var/research_points = 0
	var/collected_souls = 0

/mob/living/Initialize(mapload)
	. = ..()
	storyteller_stat_holder = new() // STORYTELLER_STATS
	AddComponent(/datum/component/aura)

/mob/living/Destroy()
	lastattacked = null
	drunked_of = null
	QDEL_NULL(storyteller_stat_holder)
	beastmaster_minions = null
	minion_command_components = null
	grabbed_by_tentacle = null
	return ..()

/mob/living/set_pull_offsets(mob/living/mob_to_set, grab_state = GRAB_PASSIVE, animate = TRUE)
	. = ..()
	SEND_SIGNAL(mob_to_set, COMSIG_LIVING_SET_PULL_OFFSET)

/mob/living/reset_pull_offsets(mob/living/M, override)
	. = ..()
	SEND_SIGNAL(M, COMSIG_LIVING_RESET_PULL_OFFSETS)
