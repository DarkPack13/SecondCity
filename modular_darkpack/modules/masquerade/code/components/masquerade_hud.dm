//Component that adds an exclamation mark to things that have caused you to breach the masquerade.
/datum/component/masquerade_hud
	dupe_mode = COMPONENT_DUPE_ALLOWED
	var/client/masquerade_breacher
	var/image/new_masquerade_image

/datum/component/masquerade_hud/Initialize(mob/_masquerade_breacher)
	if(!_masquerade_breacher.client)
		return COMPONENT_INCOMPATIBLE

	masquerade_breacher = _masquerade_breacher.client

	RegisterSignal(parent, COMSIG_MASQUERADE_HUD_DELETE, PROC_REF(delete_myself))

	create_masquerade_overlay()

/datum/component/masquerade_hud/proc/delete_myself(atom/source, mob/player_breacher)
	SIGNAL_HANDLER

	if((masquerade_breacher == player_breacher.client) || !masquerade_breacher)
		qdel(src)

/datum/component/masquerade_hud/Destroy(force)
	UnregisterSignal(parent, COMSIG_MASQUERADE_HUD_DELETE)
	masquerade_breacher?.images -= new_masquerade_image
	remove_image_from_client(new_masquerade_image, masquerade_breacher)
	masquerade_breacher = null
	new_masquerade_image = null
	return ..()

/datum/component/masquerade_hud/proc/create_masquerade_overlay()
	SIGNAL_HANDLER

	var/atom/atom_parent = parent
	if(!new_masquerade_image)
		new_masquerade_image = image(icon = 'icons/obj/storage/closet.dmi', loc = atom_parent, icon_state = "cardboard_special", layer = ABOVE_ALL_MOB_LAYER, pixel_z = 32)
	add_image_to_client(new_masquerade_image, masquerade_breacher)
