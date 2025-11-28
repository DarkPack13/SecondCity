/obj/item/ritual_tome/necromancy
	name = "necromancy tome"
	desc = "An old tome bound in peculiar leather."
	icon_state = "necronomicon"
	icon = 'modular_darkpack/modules/ritual_necromancy/icons/necromancy_tome.dmi'
	onflooricon = 'modular_darkpack/modules/ritual_necromancy/icons/necromancy_tome_onfloor.dmi'
	rune_type = /obj/ritual_rune/necromancy

/obj/item/ritual_tome/necromancy/attack_self(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/ritual_tome/necromancy/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NecromancyVendor", name)
		ui.open()

/datum/crafting_recipe/necrotome
	name = "Necromantic Ritualism Tome"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/ectoplasm = 1)
	result = /obj/item/ritual_tome/necromancy
	category = CAT_MISC

/datum/crafting_recipe/necrotome/is_recipe_available(mob/user)
	return HAS_TRAIT(user, TRAIT_NECROMANCY_KNOWLEDGE)
