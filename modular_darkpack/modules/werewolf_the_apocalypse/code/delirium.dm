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
	var/datum/weakref/scary_wolf_ref
	var/image/scary_static

/datum/status_effect/delirium/on_creation(mob/living/new_owner, mob/big_wolf)
	scary_wolf_ref = WEAKREF(big_wolf)
	. = ..()
	linked_alert.desc += " You are filled with <b>[willpower_levels[willpower_dots]]</b>."

/datum/status_effect/delirium/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return FALSE
	if(!human_owner.affected_by_delirium())
		return FALSE
	var/mob/living/wolf = scary_wolf_ref?.resolve()
	if(!wolf)
		return FALSE

	to_chat(owner, span_boldwarning("Something DEEP inside you fill you with <b>[willpower_levels[willpower_dots]]</b> at the sight of [wolf]"))
	willpower_dots = clamp(human_owner.st_get_stat(STAT_PERMANENT_WILLPOWER), 1, 10)

	if(owner.client)
		// dir SOUTH is admitting i compeletly lost the fight against this stupid bullshit and cant get the image to properly mimmic the direction of the mob.
		var/image/overlay_image = image(loc = wolf, dir = SOUTH)
		overlay_image.appearance = wolf.appearance
		overlay_image.override = TRUE
		overlay_image.name = "Unknown"
		overlay_image.pixel_y = 0
		overlay_image.pixel_x = 0
		overlay_image.pixel_w = 0
		overlay_image.pixel_z = 0
		SET_PLANE_EXPLICIT(overlay_image, ABOVE_GAME_PLANE, wolf)

		var/mutable_appearance/static_effect = mutable_appearance('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/big_static.dmi', "static_base")
		static_effect.color = "#373642"
		static_effect.blend_mode = BLEND_INSET_OVERLAY
		overlay_image.overlays += static_effect

		owner.client.images += overlay_image
		scary_static = overlay_image

/datum/status_effect/delirium/on_remove()
	. = ..()
	to_chat(owner, span_notice("Your heightened emotions subside and you begin to calm."))
	owner.client?.images -= scary_static
	QDEL_NULL(scary_static)

/datum/status_effect/delirium/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return
	if(!human_owner.affected_by_delirium())
		return
	if(COOLDOWN_FINISHED(src, message_cooldown))
		COOLDOWN_START(src, message_cooldown, rand(10, 15) SECONDS)
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
	if(issupernatural(src))
		return FALSE

	if(st_get_stat(STAT_PERMANENT_WILLPOWER) >= 10)
		return FALSE

	return TRUE
