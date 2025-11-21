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
	update_aura()

/datum/component/aura/UnregisterFromParent()
	var/mob/parent_mob = parent
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.remove_atom_from_hud(parent_mob)

	remove_verb(parent_mob, /mob/verb/emotion_panel)
	UnregisterSignal(parent_mob, COMSIG_MOB_EMOTION_CHANGED)
	return ..()

/datum/component/aura/proc/update_emotions(mob/changed_mob, new_emotion)
	SIGNAL_HANDLER

	if(current_aura == new_emotion)
		return

	current_aura = GLOB.aura_list[new_emotion]
	update_aura()

/datum/component/aura/proc/update_aura()
	var/mob/parent_mob = parent
	var/image/holder = parent_mob.hud_list[AUSPEX_AURA_HUD]
	if(!holder)
		holder = new
	var/mutable_appearance/aura_appearance = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "aura", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)
	update_aura_colors(aura_appearance)
	holder.appearance = aura_appearance
	update_aura_overlays(holder)
	update_aura_filters(holder)

// use RGB blend for multiple emotions being selected

/datum/component/aura/proc/is_color(input_text)
	if(findtext(input_text, GLOB.is_color))
		return TRUE
	return FALSE

/datum/component/aura/proc/update_aura_colors(mutable_appearance/aura_appearance)
	if(is_color(current_aura))
		aura_appearance.color = current_aura
		aura_appearance.alpha = 255
	else
		aura_appearance.alpha = 0
		aura_appearance.color = null

/datum/component/aura/proc/update_aura_overlays(image/holder)
	holder.cut_overlays()
	var/mob/parent_mob = parent

	if(current_aura == AURA_ANXIOUS)
		var/icon/temporary_icon_holder = icon('modular_darkpack/modules/powers/icons/auras.dmi', "aura")
		var/icon/static_icon = getStaticIcon(temporary_icon_holder)
		var/mutable_appearance/static_image = mutable_appearance(static_icon, "aura", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)
		static_image.appearance_flags |= RESET_COLOR | RESET_ALPHA
		holder.add_overlay(static_image)

	if(HAS_TRAIT(parent_mob, TRAIT_DIABLERIE))
		var/mutable_appearance/diablerie_image = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "aura", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)
		diablerie_image.color = COLOR_HALF_TRANSPARENT_BLACK
		holder.add_overlay(diablerie_image)

/datum/component/aura/proc/update_aura_filters(image/holder)
	var/mob/parent_mob = parent

	remove_wibbly_filters(holder)
	if(HAS_TRAIT(parent_mob, TRAIT_IN_FRENZY))
		apply_wibbly_filters(holder)
