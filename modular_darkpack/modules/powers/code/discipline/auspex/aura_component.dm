/datum/atom_hud/data/auspex_aura
	hud_icons = list(AUSPEX_AURA_HUD)

/datum/component/aura
	// A list of currently selected emotions by the player
	var/current_aura = AURA_INNOCENT

/datum/component/aura/RegisterWithParent()
	. = ..()
	var/mob/parent_mob = parent
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.add_atom_to_hud(parent_mob)

	add_verb(parent_mob, /mob/verb/emotion_panel)
	RegisterSignal(parent_mob, COMSIG_MOB_EMOTION_CHANGED, PROC_REF(update_emotions))
	RegisterSignal(parent_mob, COMSIG_MOB_UPDATE_AURA, PROC_REF(update_aura))
	update_aura()

/datum/component/aura/UnregisterFromParent()
	var/mob/parent_mob = parent
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.remove_atom_from_hud(parent_mob)

	remove_verb(parent_mob, /mob/verb/emotion_panel)
	UnregisterSignal(parent_mob, list(COMSIG_MOB_EMOTION_CHANGED, COMSIG_MOB_UPDATE_AURA))
	return ..()

/datum/component/aura/proc/update_emotions(mob/changed_mob, new_emotion)
	SIGNAL_HANDLER

	if(current_aura == new_emotion)
		return

	current_aura = GLOB.aura_list[new_emotion]
	update_aura()

/datum/component/aura/proc/update_aura()
	SIGNAL_HANDLER

	var/mob/parent_mob = parent
	var/image/holder = parent_mob.hud_list[AUSPEX_AURA_HUD]
	if(!holder)
		holder = new
	var/mutable_appearance/aura_appearance = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "aura", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)
	update_aura_colors(aura_appearance, holder)
	update_aura_overlays(aura_appearance, holder)
	update_aura_filters(aura_appearance, holder)

/datum/component/aura/proc/is_color(input_text)
	if(findtext(input_text, GLOB.is_color))
		return TRUE
	return FALSE

/datum/component/aura/proc/update_aura_colors(mutable_appearance/aura_appearance, image/holder)
	var/output_color
	if(is_color(current_aura))
		output_color = current_aura
	else
		output_color = null

	aura_appearance.color = output_color
	holder.appearance = aura_appearance

	var/mob/parent_mob = parent
	if(iskindred(parent_mob))
		var/icon/temporary_icon_holder = holder.appearance
		var/mutable_appearance/aura_image = mutable_appearance(temporary_icon_holder, "aura", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)

		var/list/hsv_color_value = rgb2hsv(holder.color)
		hsv_color_value[2] = hsv_color_value[2] * 0.7 // Reduce saturation for kindred

		aura_image.color = hsv2rgb(hsv_color_value)
		holder.appearance = aura_image


/datum/component/aura/proc/update_aura_overlays(mutable_appearance/aura_appearance, image/holder)
	holder.cut_overlays()
	var/mob/parent_mob = parent

	if(HAS_TRAIT(parent_mob, TRAIT_DIABLERIE))
		var/image/diablerie_image = image('modular_darkpack/modules/powers/icons/auras.dmi', parent_mob, "diab", ABOVE_MOB_LAYER+1)
		holder.add_overlay(diablerie_image)

	if(current_aura == AURA_ANXIOUS)
		var/icon/temporary_icon_holder = icon('modular_darkpack/modules/powers/icons/auras.dmi', "aura")
		var/icon/static_icon = getStaticIcon(temporary_icon_holder)
		var/mutable_appearance/static_image = mutable_appearance(static_icon, "aura", ABOVE_MOB_LAYER+2, parent_mob, GAME_PLANE)
		static_image.appearance_flags |= RESET_COLOR
		holder.add_overlay(static_image)

	if(isghoul(parent_mob))
		var/icon/temporary_icon_holder = icon('modular_darkpack/modules/powers/icons/auras.dmi', "aurablotch")
		var/mutable_appearance/aura_blotches = mutable_appearance(temporary_icon_holder, "aurablotch", ABOVE_MOB_LAYER+3, parent_mob, GAME_PLANE)

		var/list/hsv_color_value = rgb2hsv(aura_appearance.color)
		hsv_color_value[2] = hsv_color_value[2] * 0.7 // Reduce saturation for ghouls

		var/icon/icon_mask = getIconMask(aura_blotches)
		var/mutable_appearance/aura_icon = new(aura_appearance)
		aura_icon.color = hsv2rgb(hsv_color_value)
		aura_icon.add_filter("alpha_mask", 1, alpha_mask_filter(icon = icon_mask))
		holder.add_overlay(aura_icon)

	if(isavatar(parent_mob) || isobserver(parent_mob))
		holder.opacity = holder.opacity * 0.5

/datum/component/aura/proc/update_aura_filters(mutable_appearance/aura_appearance, image/holder)
	var/mob/parent_mob = parent

	remove_wibbly_filters(holder)
	if(HAS_TRAIT(parent_mob, TRAIT_IN_FRENZY))
		apply_wibbly_filters(holder)

