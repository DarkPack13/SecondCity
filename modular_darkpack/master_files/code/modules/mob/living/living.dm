/mob/living/Initialize(mapload)
	. = ..()
	storyteller_stats = create_new_stat_prefs(storyteller_stats)
	AddComponent(/datum/component/aura)
	become_area_sensitive("zone_hud")
	update_zone_hud(src, get_area(src))

/mob/living/Destroy()
	lastattacked = null
	drunked_of = null
	storyteller_stats = null
	beastmaster_minions = null
	minion_command_components = null
	grabbed_by_tentacle = null
	QDEL_LAZYLIST(splats)
	return ..()

/mob/living/set_pull_offsets(mob/living/mob_to_set, grab_state = GRAB_PASSIVE, animate = TRUE)
	. = ..()
	SEND_SIGNAL(mob_to_set, COMSIG_LIVING_SET_PULL_OFFSET)

/mob/living/reset_pull_offsets(mob/living/M, override)
	. = ..()
	SEND_SIGNAL(M, COMSIG_LIVING_RESET_PULL_OFFSETS)
