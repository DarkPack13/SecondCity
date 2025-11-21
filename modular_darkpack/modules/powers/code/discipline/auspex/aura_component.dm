/datum/component/aura
	// The currently selected aura by the player
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
	var/mutable_appearance/target = mutable_appearance('icons/mob/huds/hud.dmi', "hudstat", ABOVE_MOB_LAYER, parent_mob, GAME_PLANE)
	holder.appearance = target
	holder.color = current_aura
