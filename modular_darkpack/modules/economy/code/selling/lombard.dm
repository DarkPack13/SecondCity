/// Difficulty for the roll when selling an item (charisma + finance)
#define SALE_DIFFICULTY 6
#define BOTCH_FAILURE_PENALTY 0.5

/obj/lombard
	name = "pawnshop"
	desc = "Sell your stuff."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	icon_state = "sell"
	icon = 'modular_darkpack/modules/retail/icons/vendors_shops.dmi'
	anchored = TRUE
	var/black_market = FALSE

/obj/lombard/attackby(obj/item/W, mob/living/carbon/human/user, params)
	var/datum/component/selling/selling_comp = W.GetComponent(/datum/component/selling)
	if(!selling_comp)
		return ..()

	if(selling_comp.illegal != black_market)
		to_chat(user, span_warning("[black_market ? "This" : "The pawnshop"] doesn't accept [selling_comp.illegal ? "illegal" : "legal"] goods."))
		return

	sell_one_item(W, user)

/// Sell a single item
/obj/lombard/proc/sell_one_item(obj/item/sold, mob/living/user)
	var/datum/component/selling/selling_comp = sold.GetComponent(/datum/component/selling)
	if(!selling_comp)
		return FALSE

	if(!selling_comp.can_sell())
		to_chat(user, selling_comp.sale_fail_message())
		return FALSE

	var/sale_price = calculate_sale_price(sold, user, selling_comp)
	spawn_money(sale_price, loc)

	if(ishuman(user) && selling_comp.humanity_loss)
		user.AdjustHumanity(selling_comp.humanity_loss, selling_comp.humanity_loss_limit)

	// feedback
	playsound(loc, 'modular_darkpack/modules/deprecated/sounds/sell.ogg', 50, TRUE)
	to_chat(user, selling_comp.sale_success_message())

	log_game("[key_name(user)] sold [sold] at [src] for $[sale_price]")

	qdel(sold)
	return TRUE

/// Sell multiple items of the same category
/// Returns list of successfully sold items
/obj/lombard/proc/sell_multiple_items(list/items_to_sell, mob/living/user)
	if(!length(items_to_sell))
		return list()

	var/list/sold_items = list()
	var/total_sale_price = 0

	// Make a single roll to sell all your items in bulk
	var/negotiation_success_count = 0
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/negotiation_dice = H.st_get_stat(STAT_CHARISMA) + H.st_get_stat(STAT_FINANCE)
		if(negotiation_dice > 0)
			negotiation_success_count = SSroll.storyteller_roll(negotiation_dice, SALE_DIFFICULTY, H, src, TRUE)

	for(var/obj/item/sold in items_to_sell)
		var/datum/component/selling/selling_comp = sold.GetComponent(/datum/component/selling)
		if(!selling_comp)
			continue

		if(!selling_comp.can_sell())
			to_chat(user, selling_comp.sale_fail_message())
			continue

		// calculate the sale price of each item with the successes from the roll and add it to total sale price.
		//for ex, sell 2 under/vampire/archivist. var/cost is 75, 2 successes makes them $150 each, $300 is printed.
		var/sale_price = calculate_sale_price(sold, user, selling_comp, negotiation_success_count)
		total_sale_price += sale_price

		sold_items += sold
		to_chat(user, selling_comp.sale_success_message())

	if(!length(sold_items))
		return list()

	spawn_money(total_sale_price, loc)
	playsound(loc, 'modular_darkpack/modules/deprecated/sounds/sell.ogg', 50, TRUE)

	return sold_items

/// calculate the actual sale price for an item - each success adds var/cost from selling component
/obj/lombard/proc/calculate_sale_price(obj/item/sold, mob/living/user, datum/component/selling/selling_comp, negotiation_success_count = null)
	var/base_price = selling_comp.cost

	// handle for stacks - gold bars from bank vaults for example
	var/stack_multiplier = 1
	if(istype(sold, /obj/item/stack))
		var/obj/item/stack/stack_item = sold
		stack_multiplier = stack_item.amount

	// if negotiation result was passed for a bulk sale, use it
	if(!isnull(negotiation_success_count))
		if(negotiation_success_count > 0)
			return round(base_price * stack_multiplier * negotiation_success_count)
		return round(base_price * stack_multiplier * BOTCH_FAILURE_PENALTY)

	// otherwise, roll for negotiation in a single item sale
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/negotiation_dice = H.st_get_stat(STAT_CHARISMA) + H.st_get_stat(STAT_FINANCE)

		if(negotiation_dice > 0)
			var/success_count = SSroll.storyteller_roll(negotiation_dice, SALE_DIFFICULTY, H, src, TRUE)

			if(success_count > 0)
				return round(base_price * stack_multiplier * success_count)
			return round(base_price * stack_multiplier * BOTCH_FAILURE_PENALTY)

	// No negotiation dice (which should rarely happen) = ZERO! Completely scammed at 0 finance 0 charisma
	return 0

/obj/lombard/proc/spawn_money(amount, atom/spawn_location)
	if(amount <= 0)
		return

	var/remaining = amount

	while(remaining > 0)
		var/obj/item/stack/dollar/money = new()
		money.amount = min(remaining, money.max_amount)
		remaining -= money.amount

		money.icon = money.onflooricon
		money.update_icon_state()
		money.forceMove(spawn_location)

/obj/lombard/mouse_drop_receive(atom/sold, mob/living/user, params)
	. = ..()

	var/datum/component/selling/selling_comp = sold.GetComponent(/datum/component/selling)
	if(!selling_comp)
		to_chat(user, span_warning("[sold] cannot be sold here."))
		return

	if(selling_comp.illegal != black_market)
		to_chat(user, span_warning("[black_market ? "This" : "The pawnshop"] doesn't accept [selling_comp.illegal ? "illegal" : "legal"] goods."))
		return

	if(!src.IsReachableBy(user))
		to_chat(user, span_warning("You're too far from [src]!"))
		return

	if(!sold.IsReachableBy(user))
		to_chat(user, span_warning("You can't reach [sold]!"))
		return

	var/turf/item_turf = sold.loc
	if(!isturf(item_turf))
		to_chat(user, span_warning("Items must be on the ground to bulk sell."))
		return

	var/list/items_to_sell = get_matching_items(item_turf, selling_comp)

	if(!length(items_to_sell))
		return

	if(length(items_to_sell) == 1)
		sell_one_item(sold, user)
		return

	// Humanity loss warning for bulk sales
	if(selling_comp.humanity_loss && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/datum/splat/vampire/kindred/vampirism = iskindred(H)
		if(!iskindred(H) || !vampirism.enlightenment)
			var/humanity_loss_modifier = HAS_TRAIT(H, TRAIT_SENSITIVE_HUMANITY) ? 2 : 1
			var/total_humanity_risk = length(items_to_sell) * humanity_loss_modifier * selling_comp.humanity_loss

			if(selling_comp.humanity_loss_limit < H.humanity)
				if((selling_comp.humanity_loss_limit <= 0) && ((H.humanity + total_humanity_risk) <= 0))
					to_chat(user, span_warning("Selling all of this will remove all of your Humanity!"))
					return

				var/max_loss = min(H.humanity - selling_comp.humanity_loss_limit, -total_humanity_risk)
				var/choice = alert(H, "Your HUMANITY is currently at [H.humanity], you will LOSE [max_loss] humanity if you proceed. Do you proceed?",,"Yes", "No")
				if(choice == "No")
					return

				if(!src.IsReachableBy(user) || !sold.IsReachableBy(user))
					return

	var/list/sold_items = sell_multiple_items(items_to_sell, user)

	if(!length(sold_items))
		return

	// Apply humanity loss for all sold items at once
	if(selling_comp.humanity_loss && ishuman(user))
		var/total_humanity_loss = selling_comp.humanity_loss * length(sold_items)
		user.AdjustHumanity(total_humanity_loss, selling_comp.humanity_loss_limit)

	for(var/obj/item/sold_item in sold_items)
		qdel(sold_item)

/obj/lombard/proc/get_matching_items(turf/item_turf, datum/component/selling/reference_comp)
	var/list/matching_items = list()

	for(var/obj/item/check_item in item_turf)
		var/datum/component/selling/check_comp = check_item.GetComponent(/datum/component/selling)

		if(!check_comp)
			continue

		// Must be exact same category such as "fish"
		if(check_comp.object_category != reference_comp.object_category)
			continue

		if(check_comp.illegal != reference_comp.illegal)
			continue

		if(check_comp.humanity_loss != reference_comp.humanity_loss)
			continue

		if(check_comp.humanity_loss_limit != reference_comp.humanity_loss_limit)
			continue

		matching_items += check_item

	return matching_items

/obj/lombard/blackmarket
	name = "black market"
	desc = "Sell illegal goods."
	icon_state = "sell_d"
	black_market = TRUE

#undef SALE_DIFFICULTY
#undef BOTCH_FAILURE_PENALTY
