/mob/living
	COOLDOWN_DECLARE(masquerade_timer)

/mob/living/Initialize(mapload)
	. = ..()
	storyteller_stat_holder = new() // STORYTELLER_STATS

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_SET_PULL_OFFSET)

/mob/living/reset_pull_offsets(mob/living/pull_target, override)
	. = ..()
	SEND_SIGNAL(pull_target, COMSIG_LIVING_RESET_PULL_OFFSETS)
