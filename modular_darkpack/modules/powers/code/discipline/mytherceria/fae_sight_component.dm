// ! Largely copied from modular_darkpack/modules/powers/code/discipline/auspex/aura_component.dm, originally written by XeonMations - dwinters99
/datum/atom_hud/data/fae_sight_aura
	hud_icons = list(FAE_SIGHT_AURA_HUD)

/datum/component/fae_sight

/datum/component/fae_sight/RegisterWithParent()
	. = ..()
	var/atom/parent_atom = parent
	parent_atom.hud_possible += FAE_SIGHT_AURA_HUD
	var/datum/atom_hud/data/fae_sight_aura/target_hud = GLOB.huds[DATA_HUD_FAE_SIGHT]
	to_chat(world, "[parent_atom.type]")
	target_hud.add_atom_to_hud(parent_atom)

	RegisterSignal(parent_atom, COMSIG_MOB_UPDATE_AURA, PROC_REF(update_fae_sight_aura_hud))
	update_fae_sight_aura_hud()

/datum/component/fae_sight/UnregisterFromParent()
	var/atom/parent_atom = parent
	var/datum/atom_hud/data/fae_sight_aura/target_hud = GLOB.huds[DATA_HUD_FAE_SIGHT]
	target_hud.remove_atom_from_hud(parent_atom)
	parent_atom.hud_possible -= FAE_SIGHT_AURA_HUD

	UnregisterSignal(parent_atom, list(COMSIG_MOB_UPDATE_AURA))
	return ..()

/datum/component/fae_sight/proc/get_fae_sight_aura()
	var/new_fae_sight_aura

	if(isliving(parent))
		var/mob/living/parent_mob = parent
		var/datum/splat/parent_splat = parent_mob.get_primary_splat()
		new_fae_sight_aura = parent_splat.fae_sight_aura
	else
		new_fae_sight_aura = parent.fae_sight_aura
	return new_fae_sight_aura

/datum/component/fae_sight/proc/update_fae_sight_aura_hud()
	SIGNAL_HANDLER

	var/atom/parent_atom = parent
	var/image/holder = parent_atom.hud_list[FAE_SIGHT_AURA_HUD]
	if(!holder)
		holder = new
	var/mutable_appearance/fae_sight_aura_appearance = mutable_appearance('modular_darkpack/modules/powers/icons/fae_sight_auras.dmi', parent_atom.fae_sight_aura, ABOVE_MOB_LAYER, parent_atom, GAME_PLANE)
	update_fae_sight_aura_overlays(fae_sight_aura_appearance, holder)

/datum/component/fae_sight/proc/update_fae_sight_aura_overlays(mutable_appearance/fae_sight_aura_appearance, image/holder)
	holder.cut_overlays()
	holder.opacity = 0.75

	if(ismob(parent))
		var/mob/parent_mob = parent

		if(isavatar(parent_mob) || isobserver(parent_mob))
			holder.opacity = holder.opacity * 0.5
