/datum/component/aura
	// The currently selected aura by the player
	var/current_aura = AURA_DEPRESSED
	// The image of the aura.
	var/image/aura_image
	// Weakref list of mobs with the aura_image shown to
	var/list/shown_to

/datum/component/aura/RegisterWithParent()
	. = ..()
	shown_to = list()
	RegisterSignal(parent, COMSIG_SHOW_AURA, PROC_REF(show_aura))
	RegisterSignal(parent, COMSIG_HIDE_AURA, PROC_REF(hide_aura))

/datum/component/aura/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_SHOW_AURA, COMSIG_HIDE_AURA))
	for(var/datum/weakref/mob_weakref as anything in shown_to)
		var/mob/mob_reference = mob_weakref.resolve()
		if(mob_reference)
			hide_aura(src, mob_reference)
	shown_to = null
	destroy_aura()
	return ..()

/datum/component/aura/proc/create_aura()
	var/mob/parent_mob = parent

	var/mutable_appearance/aura = new(parent_mob.appearance)

	var/mutable_appearance/overlay = mutable_appearance('icons/effects/effects.dmi', "static_base", ABOVE_NORMAL_TURF_LAYER)
	overlay.color = current_aura
	overlay.appearance_flags |= RESET_COLOR

	aura.add_overlay(overlay)
	aura_image = aura
	aura_image.loc = parent_mob

/datum/component/aura/proc/destroy_aura()
	QDEL_NULL(aura_image)

/datum/component/aura/proc/show_aura(datum/source, mob/viewing_mob)
	if(!aura_image)
		create_aura()
	viewing_mob.client?.images += aura_image
	shown_to += WEAKREF(viewing_mob)

/datum/component/aura/proc/hide_aura(datum/source, mob/viewing_mob)
	viewing_mob.client?.images -= aura_image
	for(var/datum/weakref/mob_weakref as anything in shown_to)
		var/mob/mob_reference = mob_weakref.resolve()
		if(mob_reference == viewing_mob)
			shown_to -= mob_weakref
