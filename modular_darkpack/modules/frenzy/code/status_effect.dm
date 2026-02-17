/datum/client_colour/frenzy
	priority = CLIENT_COLOR_IMPORTANT_PRIORITY
	color = COLOR_RED

/datum/status_effect/frenzy
	id = "frenzy"
	duration = STATUS_EFFECT_PERMANENT
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/frenzy
	var/datum/weakref/frenzy_ref

/datum/status_effect/frenzy/on_creation(mob/living/new_owner, atom/frenzy_target)
	. = ..()
	if(!.)
		return
	new_owner.add_client_colour(/datum/client_colour/frenzy, FRENZY_TRAIT)

	if(frenzy_target)
		frenzy_ref = WEAKREF(frenzy_target.add_alt_appearance(
			/datum/atom_hud/alternate_appearance/basic/one_person,
			"frenzy_target",
			image(icon = 'modular_darkpack/modules/frenzy/icons/frenzy_overlay.dmi', icon_state = "frenzy_overlay", loc = frenzy_target),
			null,
			new_owner,
		))

/datum/status_effect/frenzy/on_remove()
	var/datum/atom_hud/hud = frenzy_ref.resolve()
	if(hud)
		qdel(hud)
	QDEL_NULL(frenzy_ref)
	owner.remove_client_colour(FRENZY_TRAIT)
	return ..()

/atom/movable/screen/alert/status_effect/frenzy
	name = "Frenzy"
	desc = "FRENZY."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "fear"

