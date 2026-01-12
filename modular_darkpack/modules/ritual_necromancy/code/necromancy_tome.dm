/obj/item/ritual_tome/necromancy
	name = "necromancy tome"
	desc = "An old tome bound in peculiar leather."
	icon_state = "necronomicon"
	icon = 'modular_darkpack/modules/ritual_necromancy/icons/necromancy_tome.dmi'
	onflooricon = 'modular_darkpack/modules/ritual_necromancy/icons/necromancy_tome_onfloor.dmi'
	rune_type = /obj/ritual_rune/necromancy
	var/list/products_list = list(
		// placeholder, idea is that its similar to thaumaturgy archives
	)

/obj/item/ritual_tome/necromancy/attack_self(mob/user)
	if(!HAS_TRAIT(user, TRAIT_NECROMANCY_KNOWLEDGE))
		to_chat(user, span_cult("A Grimoire that contains etchings of many rituals and procedures. Sadly, you don't understand much of it."))
		return
	ui_interact(user)
	. = ..()

// NecromancyVendor.jsx in tgui/interfaces
/obj/item/ritual_tome/necromancy/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NecromancyVendor", name)
		ui.open()

/obj/item/ritual_tome/necromancy/ui_data(mob/user)
	. = list()
	.["user"] = list()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		.["user"]["souls"] = H.collected_souls
		.["user"]["name"] = "[H.name]"
		.["user"]["job"] = "[H.mind?.assigned_role?.title]"
		.["user"]["has_necromancy"] = HAS_TRAIT(H, TRAIT_NECROMANCY_KNOWLEDGE)
	else if(isliving(user))
		var/mob/living/L = user
		.["user"]["souls"] = L.collected_souls
		.["user"]["name"] = "[L.name]"
		.["user"]["job"] = "Unknown"
		.["user"]["has_necromancy"] = FALSE
	else
		.["user"]["souls"] = 0
		.["user"]["name"] = "Unknown"
		.["user"]["job"] = "Unknown"
		.["user"]["has_necromancy"] = FALSE

/obj/item/ritual_tome/necromancy/ui_act(action, params)
	if(action != "purchase")
		return ..()

	if(!HAS_TRAIT(usr, TRAIT_NECROMANCY_KNOWLEDGE))
		return FALSE

	var/mob/living/user = usr

	var/datum/data/vending_product/prize = locate(params["ref"]) in products_list

	user.collected_souls -= prize.price
	to_chat(user, span_notice("The necromancy tome resonates with dark energy as it dispenses [prize.name]!"))
	new prize.product_path(get_turf(user))
	return TRUE

/datum/crafting_recipe/necrotome
	name = "Necromantic Ritualism Tome"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/ectoplasm = 1)
	result = /obj/item/ritual_tome/necromancy
	category = CAT_MISC

/datum/crafting_recipe/necrotome/is_recipe_available(mob/user)
	return HAS_TRAIT(user, TRAIT_NECROMANCY_KNOWLEDGE)
