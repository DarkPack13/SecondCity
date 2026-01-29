/datum/crafting_recipe/typhon_brew
	name = "Typhon's Brew"
	reqs = list(/obj/item/reagent_containers/cup/glass/bottle/beer/vampire = 1, /datum/reagent/blood/vitae = 200)
	result = /obj/item/reagent_containers/cup/glass/bottle/beer/vampire/typhon
	time = 1 SECONDS
	category = CAT_CHEMISTRY

/datum/crafting_recipe/typhon_brew/is_recipe_available(mob/user)
	if(!ishuman(user))
		return FALSE

	var/datum/splat/vampire/vampire = does_use_disciplines(user)
	if(vampire?.get_discipline_power(/datum/discipline/serpentis))
		return TRUE

	return FALSE
