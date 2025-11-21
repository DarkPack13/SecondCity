/datum/atom_hud/data/auspex_aura
	hud_icons = list(AUSPEX_AURA_HUD)

/datum/component/aura
	// A list of currently selected emotions by the player
	var/current_aura = AURA_DEPRESSED

/datum/component/aura/RegisterWithParent()
	. = ..()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.add_atom_to_hud(parent)
	update_aura()

/datum/component/aura/UnregisterFromParent()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.remove_atom_from_hud(parent)
	return ..()

/datum/component/aura/proc/update_aura()
	var/mob/parent_mob = parent
	var/image/holder = parent_mob.hud_list[AUSPEX_AURA_HUD]
	var/mutable_appearance/target = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "aura", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)
	if(is_color(current_aura))
		target.color = current_aura
	holder.appearance = target

	if(HAS_TRAIT(parent_mob, TRAIT_DIABLERIE))
		var/mutable_appearance/diablerie_image = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "aura", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)
		diablerie_image.color = COLOR_HALF_TRANSPARENT_BLACK
		holder.add_overlay(diablerie_image)

// use RGB blend for multiple emotions being selected

/datum/component/aura/proc/is_color(input_text)
	if(findtext(input_text, GLOB.is_color))
		return TRUE
	return FALSE
