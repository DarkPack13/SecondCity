/mob/living
	COOLDOWN_DECLARE(masquerade_timer)

/mob/living/Initialize(mapload)
	. = ..()
	storyteller_stat_holder = new() // STORYTELLER_STATS
	AddComponent(/datum/component/aura)

/mob/living/set_pull_offsets(mob/living/mob_to_set, grab_state = GRAB_PASSIVE, animate = TRUE)
	. = ..()
	SEND_SIGNAL(mob_to_set, COMSIG_LIVING_SET_PULL_OFFSET)

/mob/living/reset_pull_offsets(mob/living/M, override)
	. = ..()
	SEND_SIGNAL(M, COMSIG_LIVING_RESET_PULL_OFFSETS)
