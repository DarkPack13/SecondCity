// Add the crafted Szlachta to Crafter's Beastmaster List
/mob/living/basic/szlachta/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	if(!isliving(crafter))
		return
	var/mob/living/carbon/human/szlachta_owner = crafter
	var/crafted_szlachta = current_recipe.result //&& new (get_turf(src))
	QDEL_NULL(ai_controller)
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	szlachta_owner.add_beastmaster_minion(crafted_szlachta)
	//qdel(src)


///mob/living/basic/szlachta/crafted_szlachta/Initialize(mapload)
//	AddElement(/datum/element/ai_retaliate)
//	. = ..()
