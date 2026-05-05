/datum/status_effect/delirium
	id = "delirium"
	status_type = STATUS_EFFECT_REFRESH
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/delirium
	COOLDOWN_DECLARE(message_cooldown)
	var/static/list/willpower_levels = list(
		"catatonic fear",
		"panic",
		"disbelief",
		"beserk",
		"terror",
		"conciliatory",
		"controlled fear",
		"curiosity",
		"bloodlust",
		"no reaction"
	)
	var/willpower_dots = 1

/datum/status_effect/delirium/on_creation(mob/living/new_owner, ...)
	. = ..()
	linked_alert.desc += " You are filled with <b>[willpower_levels[willpower_dots]]</b>."

/datum/status_effect/delirium/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return FALSE
	if(!human_owner.affected_by_delirium())
		return FALSE
	willpower_dots = clamp(human_owner.st_get_stat(STAT_PERMANENT_WILLPOWER), 1, 10)

/datum/status_effect/delirium/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return
	if(!human_owner.affected_by_delirium())
		return
	if(COOLDOWN_FINISHED(src, message_cooldown))
		COOLDOWN_START(src, message_cooldown, 15 SECONDS)
		var/message = get_message()
		if(message)
			to_chat(owner, span_boldwarning(message))


/datum/status_effect/delirium/proc/get_message()
	switch(willpower_dots)
		// Catatonic Fear
		if(1)
			return pick("FEAR", "FAINT", "COLLAPSE")
		// Panic
		if(2)
			return pick("RUN", "RUN NOW", "GET DISTANCE")
		// Disbelief
		if(3)
			return pick("HIDE", "COWER")
		// Beserk
		if(4)
			return pick("FIGHT", "KICK", "PUNCH", "BITE", "SWING")
		// Terror
		if(5)
			return pick("RUN", "RUN NOW", "GET DISTANCE", "THINK")
		// Conciliatory
		if(6)
			return pick("PLEAD", "BARGIN", "WHIMPER")
		// Controlled Fear
		if(7)
			return "fear"
		// Curiosity
		if(8)
			return pick("learn", "discover")
		// Bloodlust
		if(9)
			return "anger"
		// No reaction
		if(10)
			return

/atom/movable/screen/alert/status_effect/delirium
	name = "The Delirium"
	desc = "A supernatural fear."
	icon_state = "fear"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'

/mob/living/carbon/human/proc/affected_by_delirium()
	if(iswerewolfsplat(src))
		return FALSE

	if(st_get_stat(STAT_PERMANENT_WILLPOWER) >= 10)
		return FALSE

	return TRUE
