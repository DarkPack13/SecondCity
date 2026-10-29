//var/mob/living/basic/szlachta/crafted_szlachta
/// The owner of a created szlachta
var/mob/living/carbon/human/szlachta_owner

// Add the crafted Szlachta to Crafter's Beastmaster List
/mob/living/basic/szlachta/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	szlachta_owner = crafter
	if (length(szlachta_owner.beastmaster_minions) >= szlachta_owner.st_get_stat(STAT_LEADERSHIP) + 1) // If max minions, delete and refund
		spawn_atom_to_turf(components, szlachta_owner)
		playsound(loc, 'sound/mobs/non-humanoids/venus_trap/venus_trap_hit.ogg', 15, vary = TRUE)
		to_chat(szlachta_owner, span_warning("The creature collapses into itself infront of you! You cannot manage to maintain more of them."))
		addtimer(CALLBACK(src, PROC_REF(kill_excess_szlachta), 1 SECONDS))
	else // Get squelchy with it
		QDEL_NULL(ai_controller)
		ai_controller = new /datum/ai_controller/basic_controller/beastmaster_summon(src)
		szlachta_owner.add_beastmaster_minion(src)
		AddElement(/datum/element/ai_retaliate)
		playsound(loc, 'sound/mobs/non-humanoids/venus_trap/venus_trap_death.ogg', 15, vary = TRUE)

/mob/living/basic/szlachta/proc/kill_excess_szlachta()
	qdel(src)
