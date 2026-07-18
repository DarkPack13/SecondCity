/datum/quirk/darkpack/scary_presence // Freak Legion pg.23
	name = "Scary Presence"
	desc = {"Your corruption is obvious to those around you. Mundane humans will go out of their way to avoid or attack you, supernaturals can detect your nature, and other Fomor will avoid you."}
	value = -2
	mob_trait = TRAIT_FOMORI_SCARY_PRESENCE
	gain_text = span_notice("You feel your corruption rising to the surface.")
	lose_text = span_notice("You feel your corruption fade to the background.")
	icon = FA_ICON_GRIMACE
	allowed_splats = list(SPLAT_FOMORI)
	failure_message =  "Your corruption is too weak to surface."

/datum/status_effect/scary_presence
	id = "scary_presence"
	status_type = STATUS_EFFECT_REFRESH
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/scary_presence
	var/datum/weakref/scary_guy_ref
	var/image/scary_static
	var/scary_timer = 0
	COOLDOWN_DECLARE(aggro_cd)
	COOLDOWN_DECLARE(annoy_cd)

/datum/status_effect/scary_presence/on_creation(mob/living/new_owner, mob/evil_guy)
	scary_guy_ref = WEAKREF(evil_guy)
	. = ..()

/datum/status_effect/scary_presence/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return FALSE
	var/mob/living/guy = scary_guy_ref?.resolve()
	if(!guy)
		return FALSE
	if(get_fomori_splat(owner))
		to_chat(owner, span_cult("[guy] is cloaked in the Wyrm's damnation. Best to stay away from them."))
	else
		to_chat(owner, span_cult("Something about [guy] is making you seriously uncomfortable."))

/datum/status_effect/scary_presence/on_remove()
	. = ..()
	var/mob/living/guy = scary_guy_ref?.resolve()
	to_chat(owner, span_notice("The sense of dread you had disappears as [guy] leaves your sight."))

/datum/status_effect/scary_presence/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	var/mob/living/scary_guy = scary_guy_ref?.resolve()
	if(!human_owner)
		return
	if(isnpc(human_owner))
		var/mob/living/carbon/human/npc/unensouled = astype(owner)
		if(scary_guy in oviewers(owner, 3))
			scary_timer = clamp(scary_timer + (1 * seconds_between_ticks), 0, 15)
		else
			scary_timer = clamp(scary_timer - (2 * seconds_between_ticks), 0, 15) // Timer decays twice as fast as buildup

		if(!unensouled.staying && scary_timer < 15 && COOLDOWN_FINISHED(src, annoy_cd))
			COOLDOWN_START(src, annoy_cd, 3 TURNS)
			unensouled.Annoy(scary_guy)

		if((!unensouled.staying && scary_timer >= 15) && COOLDOWN_FINISHED(src, aggro_cd)) // If we're not an incel (staying) and we've been scared for 10 seconds
			COOLDOWN_START(src, aggro_cd, 1 TURNS)
			unensouled.Aggro(scary_guy, TRUE)

/atom/movable/screen/alert/status_effect/scary_presence
	name = "Scary Presence"
	desc = "A supernatural fear."
	icon_state = "fear"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
