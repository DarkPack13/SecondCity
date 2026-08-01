/datum/client_colour/frenzy
	priority = CLIENT_COLOR_IMPORTANT_PRIORITY
	color = COLOR_LIGHT_GRAYISH_RED

/datum/status_effect/frenzy
	id = "frenzy"
	duration = STATUS_EFFECT_PERMANENT
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/frenzy
	var/datum/weakref/frenzy_target_ref
	var/datum/weakref/frenzy_overlay_ref
	var/seconds_alone = 0

/datum/status_effect/frenzy/on_creation(mob/living/new_owner, atom/frenzy_target)
	. = ..()
	if(!.)
		return
	new_owner.add_client_colour(/datum/client_colour/frenzy, FRENZY_TRAIT)

	if(frenzy_target)
		frenzy_overlay_ref = WEAKREF(frenzy_target.add_alt_appearance(
			/datum/atom_hud/alternate_appearance/basic/one_person,
			"frenzy_target",
			image(icon = 'modular_darkpack/modules/frenzy/icons/frenzy_overlay.dmi', icon_state = "frenzy_overlay", loc = frenzy_target),
			null,
			new_owner,
		))
		frenzy_target_ref = WEAKREF(frenzy_target)

/datum/status_effect/frenzy/on_remove()
	var/datum/atom_hud/hud = frenzy_overlay_ref.resolve()
	if(hud)
		qdel(hud)
	QDEL_NULL(frenzy_overlay_ref)
	owner.remove_client_colour(FRENZY_TRAIT)
	var/mob/living/carbon/carbon_owner = astype(owner)
	carbon_owner?.exit_frenzy_mode()
	return ..()

/datum/status_effect/frenzy/tick(seconds_between_ticks)
	. = ..()

	// If left alone for an extended time, frenzies can end on their own
	if(locate(/mob/living/carbon/human) in oview(DEFAULT_SIGHT_DISTANCE, owner))
		seconds_alone = 0
	// If our target is nearby, keep frenzying (a human or even a fire)
	else if(frenzy_target_ref?.resolve() in view(DEFAULT_SIGHT_DISTANCE, owner))
		seconds_alone = 0
	else
		seconds_alone += seconds_between_ticks

	if(seconds_alone >= 15)
		qdel(src)


/atom/movable/screen/alert/status_effect/frenzy
	name = "Frenzy"
	desc = "FRENZY."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "fear"

