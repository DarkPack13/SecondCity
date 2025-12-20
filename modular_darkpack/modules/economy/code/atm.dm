/obj/machinery/atm
	name = "\improper ATM machine"
	desc = "Check your balance or make a transaction."
	icon = 'modular_darkpack/modules/economy/icons/atm.dmi'
	icon_state = "atm"
	anchored = TRUE

	max_integrity = 250
	damage_deflection = 20

	light_color = COLOR_GREEN
	light_range = 2

	circuit = /obj/item/circuitboard/machine/atm

	var/logged_in = FALSE
	var/atm_balance = 0
	// Just because there is account selected does not nesicarrly indicate logged_in is true. (you still have to enter your pin)
	var/datum/bank_account/logged_account

/obj/machinery/atm/examine(mob/user)
	. = ..()
	if(logged_account)
		. += span_notice("The screen is active with an account logged in.")

/obj/machinery/atm/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_creditcard(tool))
		var/obj/item/card/credit/card = tool
		if(logged_in)
			to_chat(user, span_notice("Someone is already logged in."))
			return ITEM_INTERACT_BLOCKING
		logged_account = card.registered_account
		to_chat(user, span_notice("Card swiped."))
		return ITEM_INTERACT_SUCCESS
	else if(iscash(tool))
		if(!logged_in)
			to_chat(user, span_notice("You need to be logged in."))
			return ITEM_INTERACT_BLOCKING
		var/value = tool.get_item_credit_value()
		atm_balance += value
		to_chat(user, span_notice("You have deposited [value] dollars into [src]. [src] now holds [atm_balance] dollars."))
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

/obj/machinery/atm/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Atm", name)
		ui.open()

/obj/machinery/atm/ui_data(mob/user)
	var/list/data = list()
	data["logged_in"] = logged_in
	data["card"] = logged_account ? TRUE : FALSE
	data["atm_balance"] = atm_balance
	if(logged_account)
		data["account_balance"] = logged_account.account_balance
		data["account_holder"] = logged_account.account_holder
		data["account_id"] = logged_account.account_id
		data["bank_pin"] = logged_account.bank_pin
	else
		data["account_balance"] = null
		data["account_holder"] = null
		data["account_id"] = null
		data["bank_pin"] = null

	return data

/obj/machinery/atm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!logged_account)
		to_chat(usr, span_notice("You need to swipe your card before interacting with [src]."))
		return FALSE
	switch(action)
		if("login")
			if(params["bank_pin"] == logged_account.bank_pin)
				logged_in = TRUE
				return TRUE
			else
				return FALSE
		if("logout")
			logged_in = FALSE
			logged_account = null
			return TRUE
		if("withdraw")
			var/amount = text2num(params["withdraw_amount"])
			if(amount != round(amount))
				to_chat(usr, span_notice("Withdraw amount must be a round number."))
			else if(logged_account.account_balance < amount)
				to_chat(usr, span_notice("Insufficient funds."))
			else
				while(amount > 0)
					var/drop_amount = min(amount, 1000)
					var/obj/item/stack/dollar/cash = new(loc, drop_amount)
					to_chat(usr, span_notice("You have withdrawn [drop_amount] dollars."))
					try_put_in_hand(cash, usr)
					amount -= drop_amount
					logged_account.account_balance -= drop_amount
			return TRUE
		if("change_pin")
			var/new_pin = params["new_pin"]
			logged_account.bank_pin = new_pin
			return TRUE
		if("deposit")
			if(atm_balance > 0)
				logged_account.account_balance += atm_balance
				to_chat(usr, span_notice("You have deposited [atm_balance] dollars into your card. Your new balance is [logged_account.account_balance] dollars."))
				atm_balance = 0
				return TRUE
			else
				to_chat(usr, span_notice("The ATM is empty. Nothing to deposit."))
				return TRUE

/obj/item/circuitboard/machine/atm
	name = "\improper ATM machine"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/atm
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/servo = 2,
	)

