/obj/item/necromancy_tome/ui_data(mob/user)
	. = list()
	.["user"] = list()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		.["user"]["souls"] = H.collected_souls
		.["user"]["name"] = "[H.name]"
		.["user"]["job"] = "[H.mind?.assigned_role]"
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

/obj/item/necromancy_tome/ui_act(action, params)
	if(action != "purchase")
		return ..()

	if(!isliving(usr))
		return ..()

	// for now, there are no items in the prize list, but this is ready for future implementation
	to_chat(usr, span_notice("The tome whispers that its pages remain empty, awaiting dark knowledge..."))
	return TRUE


/obj/structure/retail/necromancy
	name = "Necromantic Grimoire"
	desc = "A sinister grimoire that trades necromantic knowledge and artifacts for the souls of the departed."
	icon_state = "mining"
	//owner_needed = FALSE
	//dispenses_dollars = FALSE
	products_list = list(
		// Empty for now
	)

// NecromancyVendor.jsx in tgui/interfaces
/obj/structure/retail/necromancy/necromancy/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NecromancyVendor", name)
		ui.open()

/obj/structure/retail/necromancy/necromancy/ui_data(mob/user)
	. = list()
	.["user"] = list()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		.["user"]["souls"] = H.collected_souls
		.["user"]["name"] = "[H.name]"
		.["user"]["job"] = "[H.mind?.assigned_role]"
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

/obj/structure/retail/necromancy/necromancy/ui_act(action, params)
	if(action != "purchase")
		return ..()

	if(!isliving(usr))
		return

	var/mob/living/L = usr

	var/datum/data/vending_product/prize = locate(params["ref"]) in products_list
	if(!prize || !(prize in products_list))
		to_chat(usr, span_alert("Error: Invalid choice!"))
		//flick(icon_deny, src)
		return

	if(prize.price > L.collected_souls)
		to_chat(usr, span_alert("Error: Insufficient souls for [prize.name]! You need [prize.price] souls."))
		//flick(icon_deny, src)
		return

	// Deduct souls from purchase
	L.collected_souls -= prize.price
	to_chat(usr, span_notice("The Bone Codex resonates with dark energy as it dispenses [prize.name]!"))
	new prize.product_path(loc)
	SSblackbox.record_feedback("nested tally", "necromancy_equipment_bought", 1, list("[type]", "[prize.product_path]"))
	return TRUE

// Future implementation for soul-infused artifacts
/obj/structure/retail/necromancy/necromancy/attackby(obj/item/W, mob/user, params)
	// Placeholder for future soul artifact trading system
	// Could implement trading necromantic artifacts for souls here
	return ..()
