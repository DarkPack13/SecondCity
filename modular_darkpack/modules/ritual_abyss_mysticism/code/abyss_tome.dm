/obj/item/ritual_tome/abyss
	name = "mystic tome"
	desc = "The secrets of Abyss Mysticism..."
	icon_state = "mystic"
	icon = 'modular_darkpack/modules/ritual_abyss_mysticism/icons/abyss_mysticism_tome.dmi'
	onflooricon = 'modular_darkpack/modules/ritual_abyss_mysticism/icons/abyss_mysticism_onfloor.dmi'
	rune_type = /obj/ritual_rune/abyss

/obj/item/ritual_tome/abyss/attack_self(mob/user)
	if(!HAS_TRAIT(user, TRAIT_MYSTICISM_KNOWLEDGE))
		to_chat(user, span_cult("A very dark book in color whose appearance swallows up your vision. You find it impossible to decipher without proper guidance."))
		return
	. = ..()

/datum/crafting_recipe/mystome
	name = "Abyss Mysticism Tome"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/reagent_containers/blood = 1)
	result = /obj/item/ritual_tome/abyss
	category = CAT_MISC

/datum/crafting_recipe/mystome/is_recipe_available(mob/user)
	return HAS_TRAIT(user, TRAIT_MYSTICISM_KNOWLEDGE)
