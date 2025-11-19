/obj/item/arcane_tome
	name = "arcane tome"
	desc = "The secrets of Blood Magic..."
	icon_state = "arcane"
	icon = 'modular_darkpack/modules/ritual_thaumaturgy/icons/arcane_tome.dmi'
	onflooricon = 'modular_darkpack/modules/ritual_thaumaturgy/icons/arcane_tome_onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/list/rituals = list()

/obj/item/arcane_tome/Initialize()
	. = ..()
	for(var/i in subtypesof(/obj/ritualrune))
		var/obj/ritualrune/R = new i(src)
		rituals |= R

/obj/item/arcane_tome/attack_self(mob/user)
	. = ..()
	for(var/obj/ritualrune/R in rituals)
		if(R.sacrifices.len > 0)
			var/list/required_items = list()
			for(var/item_type in R.sacrifices)
				var/obj/item/I = new item_type(src)
				required_items += I.name
				qdel(I)
			var/required_list
			if(required_items.len == 1)
				required_list = required_items[1]
			else
				for(var/item_name in required_items)
					required_list += (required_list == "" ? item_name : ", [item_name]")
			to_chat(user, span_cult("[R.thaumlevel] [R.name] - [R.desc] Requirements: [required_list]."))
		else
			to_chat(user, span_cult("[R.thaumlevel] [R.name] - [R.desc]"))

/datum/crafting_recipe/arctome
	name = "Arcane Tome"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/reagent_containers/blood = 2)
	result = /obj/item/arcane_tome
	category = CAT_MISC

/datum/crafting_recipe/arctome/is_recipe_available(mob/user)
	return HAS_TRAIT(user, TRAIT_THAUMATURGY_KNOWLEDGE)
