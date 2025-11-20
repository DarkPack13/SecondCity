/datum/component/aura
	// The currently selected aura by the player
	var/current_aura = AURA_DEPRESSED
	// The image of the aura.
	var/image/aura_image

/datum/component/aura/RegisterWithParent()
	. = ..()
	shown_to = list()
	RegisterSignal(parent, COMSIG_SHOW_AURA, PROC_REF(show_aura))
	RegisterSignal(parent, COMSIG_HIDE_AURA, PROC_REF(hide_aura))

/datum/component/aura/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_SHOW_AURA, COMSIG_HIDE_AURA))
	QDEL_NULL(aura_image)
	return ..()

/datum/component/aura/proc/create_aura()
	var/mob/parent_mob = parent
	var/image/hud_image = image(icon = 'icons/effects/effects.dmi', icon_state = "static_base")
	hud_image.pixel_w = parent_mob.pixel_x
	hud_image.pixel_z = parent_mob.pixel_y
	hud_image.color = current_aura
	parent_mob.hud_list[AUSPEX_AURA_HUD] = hud_image
	parent_mob.set_hud_image_active(AUSPEX_AURA_HUD)

/datum/component/aura/proc/show_aura(datum/source, mob/viewing_mob)
	if(!aura_image)
		create_aura()
	var/image/holder = hud_list[AUSPEX_AURA_HUD]
	holder.icon_state = "static_base"
	SET_PLANE(holder, ABOVE_LIGHTING_PLANE, parent)

/datum/component/aura/proc/hide_aura(datum/source, mob/viewing_mob)
	var/image/holder = hud_list[AUSPEX_AURA_HUD]
	holder.icon_state = null
