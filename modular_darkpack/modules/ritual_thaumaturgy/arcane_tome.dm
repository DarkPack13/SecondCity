/obj/item/ritual_tome/arcane
	name = "arcane tome"
	desc = "The secrets of Blood Magic..."
	icon_state = "arcane"
	icon = 'modular_darkpack/modules/ritual_thaumaturgy/icons/arcane_tome.dmi'
	onflooricon = 'modular_darkpack/modules/ritual_thaumaturgy/icons/arcane_tome_onfloor.dmi'
	rune_type = /obj/ritual_rune/thaumaturgy

/obj/item/ritual_tome/arcane/attack_self(mob/user)
	if(!HAS_TRAIT(user, TRAIT_THAUMATURGY_KNOWLEDGE))
		to_chat(user, span_cult("A book whose title is inscribed in latin and coated with various sigils and shapes. You'll need a teacher if you want to learn more. For some reason it wont open."))
		return
	display_rituals()

/datum/crafting_recipe/arctome
	name = "Arcane Tome"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/reagent_containers/blood = 2)
	result = /obj/item/ritual_tome/arcane
	category = CAT_MISC

/datum/crafting_recipe/arctome/is_recipe_available(mob/user)
	return HAS_TRAIT(user, TRAIT_THAUMATURGY_KNOWLEDGE)
