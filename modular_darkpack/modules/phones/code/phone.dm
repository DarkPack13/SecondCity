/obj/item/smartphone
	name = "smartphone"
	desc = "A portable device to call anyone you want."
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/phones/icons/phone_onfloor.dmi')
	icon_state = "phone"
	inhand_icon_state = "phone"
	lefthand_file = 'modular_darkpack/modules/phones/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/phones/icons/righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF | ACID_PROOF

	// There's a radio in my phone that calls me stud muffin.
	var/obj/item/radio/phone_radio

	// Contacts the phone has saved.
	var/list/contacts = list()
	// Contacts the phone has blocked.
	var/list/blocked_contacts = list()
	// The phone history of the phone.
	var/list/phone_history_list = list()
	// Currently viewed newscaster channel. Used for IRC Announcements
	var/obj/machinery/newscaster/irc_channel
	//Current sound to play when the phone is ringing.
	var/call_sound = 'modular_darkpack/modules/phones/sounds/call.ogg'
	/// Do we have a SIM card?
	var/obj/item/sim_card/sim_card
	/// Phone flags
	var/phone_flags = NONE
	/// The number the user is currently dialing.
	var/dialed_number
	// The frequency the phone is currently using to call another phone.
	var/secure_frequency
	// The frequency that is calling us.
	var/incoming_frequency
	var/obj/item/sim_card/incoming_sim_card

/obj/item/smartphone/Initialize(mapload)
	. = ..()
	sim_card = new()
	sim_card.phone_weakref = WEAKREF(src)
	RegisterSignal(sim_card, COMSIG_PHONE_RING, PROC_REF(ring))
	RegisterSignal(sim_card, COMSIG_PHONE_RING_TIMEOUT, PROC_REF(ring_timeout))
	phone_radio = new()
	irc_channel = new()
	RegisterSignal(src, COMSIG_PHONE_CALL_ACCEPTED, PROC_REF(initialize_phone_call))
	RegisterSignal(src, COMSIG_PHONE_CALL_BUSY, PROC_REF(phone_call_declined))
	RegisterSignal(sim_card, COMSIG_PHONE_CALL_ENDED, PROC_REF(end_phone_call))

/obj/item/smartphone/Destroy(force)
	. = ..()
	if(sim_card)
		UnregisterSignal(sim_card, COMSIG_PHONE_RING)
		UnregisterSignal(sim_card, COMSIG_PHONE_RING_TIMEOUT)
		UnregisterSignal(sim_card, COMSIG_PHONE_CALL_ENDED)
		sim_card.phone_weakref = null
		QDEL_NULL(sim_card)
	if(phone_radio)
		QDEL_NULL(phone_radio)
	if(irc_channel)
		QDEL_NULL(irc_channel)

/obj/item/smartphone/examine(mob/user)
	. = ..()
	. += span_notice("[EXAMINE_HINT("Interact")] to look at the screen.")
	. += span_notice("[EXAMINE_HINT("Alt-Click")] or [EXAMINE_HINT("Right-Click")] to toggle the screen.")
	if(sim_card)
		. += span_notice("[EXAMINE_HINT("Ctrl-Click")] to remove [sim_card].")
	else
		. += span_notice("You can [EXAMINE_HINT("Insert")] a SIM card.")

/obj/item/smartphone/attack_self(mob/user, modifiers)
	. = ..()
	if(!(phone_flags & PHONE_OPEN))
		toggle_screen(user)
	ui_interact(user)

/obj/item/smartphone/click_alt(mob/user)
	if(!(user.is_holding(src)))
		return CLICK_ACTION_BLOCKING
	toggle_screen(user)
	return CLICK_ACTION_SUCCESS

/obj/item/smartphone/item_ctrl_click(mob/user)
	if(!(user.is_holding(src)))
		return CLICK_ACTION_BLOCKING
	if(!sim_card)
		balloon_alert(user, "no sim card!")
		return CLICK_ACTION_BLOCKING
	if(do_after(user, 2 SECONDS, src))
		balloon_alert(user, "you remove \the [sim_card]!")
		SSphones.end_phone_call(sim_card, dialed_number)
		user.put_in_hands(sim_card)
		UnregisterSignal(sim_card, COMSIG_PHONE_RING)
		UnregisterSignal(sim_card, COMSIG_PHONE_RING_TIMEOUT)
		UnregisterSignal(sim_card, COMSIG_PHONE_CALL_ENDED)
		sim_card.phone_weakref = null
		sim_card = null
		phone_flags |= PHONE_NO_SIM
		return CLICK_ACTION_SUCCESS
	return CLICK_ACTION_BLOCKING

/obj/item/smartphone/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/sim_card))
		if(sim_card)
			balloon_alert(user, "[sim_card] already installed!")
			return FALSE
		balloon_alert(user, "you insert \the [attacking_item]!")
		sim_card = attacking_item
		user.transferItemToLoc(attacking_item, src)
		sim_card.phone_weakref = WEAKREF(src)
		phone_flags &= ~PHONE_NO_SIM
		RegisterSignal(sim_card, COMSIG_PHONE_RING, PROC_REF(ring))
		RegisterSignal(sim_card, COMSIG_PHONE_RING_TIMEOUT, PROC_REF(ring_timeout))
		RegisterSignal(sim_card, COMSIG_PHONE_CALL_ENDED, PROC_REF(end_phone_call))
		return TRUE
	return ..()

/obj/item/smartphone/ui_status(mob/user, datum/ui_state/state)
	if(!(phone_flags & PHONE_OPEN))
		return UI_CLOSE
	return ..()

/obj/item/smartphone/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Telephone")
		ui.open()

/obj/item/smartphone/ui_data(mob/user)
	var/list/data = list()
	data["my_number"] = sim_card ? sim_card.phone_number : "No SIM card inserted."
	data["no_sim_card"] = (phone_flags & PHONE_NO_SIM) ? TRUE : FALSE
	data["phone_in_call"] = (phone_flags & PHONE_IN_CALL) ? TRUE : FALSE
	data["phone_ringing"] = (phone_flags & PHONE_RINGING) ? TRUE : FALSE
	data["phone_calling"] = (phone_flags & PHONE_CALLING) ? TRUE : FALSE


	data["silence"] = isnull(call_sound)

	var/list/published_numbers = list()
	for(var/contact in SSphones.published_phone_numbers)
		UNTYPED_LIST_ADD(published_numbers, list(
			"name" = contact,
			"number" = SSphones.published_phone_numbers[contact],
		))
	data["published_numbers"] = published_numbers

	var/list/our_contacts = list()
	for(var/datum/phonecontact/contact in contacts)
		UNTYPED_LIST_ADD(our_contacts, list(
			"name" = contact.name,
			"number" = contact.number,
		))
	data["our_contacts"] = our_contacts

	var/list/our_blocked_contacts = list()
	for(var/datum/phonecontact/contact in blocked_contacts)
		UNTYPED_LIST_ADD(our_blocked_contacts, list(
			"name" = contact.name,
			"number" = contact.number,
		))
	data["our_blocked_contacts"] = our_blocked_contacts

	var/list/phone_history = list()
	for(var/datum/phonehistory/PH in phone_history_list)
		UNTYPED_LIST_ADD(phone_history, list(
			"type" = PH.call_type,
			"name" = PH.name,
			"number" = PH.number,
			"time" = PH.time
		))
	data["phone_history"] = phone_history

	var/calling = incoming_sim_card?.phone_number
	if(dialed_number)
		calling = dialed_number
	// Default to the contact name calling the phone.
	data["calling_user"] = our_contacts[calling]
	// If we dont have a contact name, refer to the published listings.
	if(!data["calling_user"])
		data["calling_user"] = published_numbers[calling]
	// Not in our contacts or published listings? Then resolve to showing the phone number.
	if(!data["calling_user"])
		data["calling_user"] = "+" + calling

	return data

/obj/item/smartphone/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	switch(action)
		if("call")
			var/phone_number = params["number"]
			initialize_phone_call(usr, phone_number)
			return TRUE

		if("hang")
			SSphones.end_phone_call(sim_card, dialed_number ? dialed_number : incoming_sim_card?.phone_number)
			return TRUE

		if("accept")
			accept_phone_call(usr)
			return TRUE

		if("decline")
			decline_phone_call()
			return TRUE

		if("publish_number")
			var/name = tgui_input_text(usr, "Input name", "Publish Number")
			if(!name)
				to_chat(usr, span_danger("You must input a name to publish your number."))
				return
			if(!sim_card?.phone_number)
				to_chat(usr, span_danger("You must insert a SIM card to publish your number."))
				return
			name = trim(copytext_char(sanitize(name), 1, MAX_MESSAGE_LEN))
			if(sim_card.phone_number in SSphones.published_phone_numbers)
				to_chat(usr, span_danger("Error: This number is already published."))
			else
				SSphones.published_phone_numbers[name] = sim_card.phone_number
				to_chat(usr, span_notice("Your number is now published."))
			return TRUE

		if("add_contact")
			var/number = params["number"]
			if(length(number) > 15)
				to_chat(usr, span_danger("Entered number is too long"))
				return
			var/stripped_number = replacetext(number, " ", "") // remove spaces
			var/new_contact_name = tgui_input_text(usr, "Input name", "Add Contact")
			if(!new_contact_name)
				to_chat(usr, span_danger("You must input a name to add a contact."))
				return

			var/datum/phonecontact/new_contact = new()
			new_contact.number = "[stripped_number]"
			new_contact.name = "[new_contact_name]"
			contacts += new_contact

			return TRUE

		if("remove_contact")
			var/name = params["name"]
			for(var/datum/phonecontact/contact in contacts)
				if(contact.name == name)
					contacts -= contact
					return TRUE
			return FALSE

		if("block")
			var/block_number = params["number"]
			if(!block_number)
				to_chat(usr, span_warning("You must provide a number."))
			if(length(block_number) > 15)
				to_chat(usr, span_warning("Invalid number."))
				return

			var/datum/phonecontact/blocked_contact = new()
			block_number = replacetext(block_number, " ", "")
			blocked_contact.number = "[block_number]"
			blocked_contact.name = "Blocked [length(blocked_contacts)+1]"
			blocked_contacts += blocked_contact
			return TRUE

		if("unblock")
			var/result = params["name"]
			for(var/datum/phonecontact/unblocked_contact in blocked_contacts)
				if(unblocked_contact.name == result)
					blocked_contacts -= unblocked_contact
					return TRUE
			return FALSE

		if("delete_call_history")
			if(!length(phone_history_list))
				to_chat(usr, span_danger("You have no call history to delete."))
				return

			to_chat(usr, "Your total amount of history saved is: [length(phone_history_list)]")
			var/number_of_deletions = tgui_input_number(usr, "Input the amount that you want to delete", "Deletion Amount", max_value = length(phone_history_list))
			//Delete the call history depending on the amount inputed by the User
			if(number_of_deletions > length(phone_history_list))
				//Verify if the requested amount in bigger than the history list.
				to_chat(usr, "You cannot delete more items than the history contains.")
				return FALSE
			else
				for(var/i in number_of_deletions)
					//It will always delete the first item of the list, so the last logs are deleted first
					var/item_to_remove = phone_history_list[1]
					phone_history_list -= item_to_remove
			to_chat(usr, "[number_of_deletions] call history entries were deleted. Remaining: [length(phone_history_list)]")
			return TRUE


		if("silent")
			if(call_sound)
				//If it is true, it will check all the other sounds for phone and disable them
				call_sound = null
				to_chat(usr, "<span class='notice'>Notifications and Sounds toggled off.</span>")
			else
				call_sound = 'modular_darkpack/modules/phones/sounds/call.ogg'
				to_chat(usr, "<span class='notice'>Notifications and Sounds toggled on.</span>")
			return TRUE

		if("terminal_sound")
			if(call_sound)
				playsound(loc, 'sound/machines/terminal/terminal_select.ogg', 15, TRUE)
			return TRUE
	return FALSE

/obj/item/smartphone/proc/toggle_screen(mob/user)
	if(phone_flags & PHONE_OPEN)
		phone_flags &= ~PHONE_OPEN
	else
		phone_flags |= PHONE_OPEN
	icon_state = (phone_flags & PHONE_OPEN) ? "phone_on" : "phone"
	inhand_icon_state = (phone_flags & PHONE_OPEN) ? "phone_on" : "phone"
	update_icon()

/**
 * Proc used for intializing a phone call, if secure_frequency isn't set, the phone is calling someone.
 * If secure_frequency is set, the phone is being called by someone.
 */
/obj/item/smartphone/proc/initialize_phone_call(mob/user, new_dialed_number)
	SIGNAL_HANDLER

	if(!sim_card)
		balloon_alert(user, "no SIM card installed!")
		return
	if(new_dialed_number == sim_card.phone_number)
		balloon_alert(user, "busy!")
		to_chat(user, span_notice("The user you are attempting to call is currently busy. Please try again later."))
		return
	if(!secure_frequency)
		secure_frequency = SSphones.initiate_phone_call(user, sim_card, new_dialed_number)
		if(secure_frequency)
			dialed_number = new_dialed_number
			phone_flags |= PHONE_CALLING
	else
		phone_radio.set_frequency(secure_frequency)
		phone_radio.set_broadcasting(TRUE)
		phone_radio.set_listening(TRUE)
		phone_flags |= PHONE_IN_CALL
		phone_flags &= ~PHONE_CALLING

/obj/item/smartphone/proc/end_phone_call()
	SIGNAL_HANDLER

	phone_radio.set_frequency(0)
	phone_radio.set_broadcasting(FALSE)
	phone_radio.set_listening(FALSE)
	secure_frequency = null
	dialed_number = null
	incoming_sim_card = null
	phone_flags &= ~PHONE_IN_CALL
	phone_flags &= ~PHONE_CALLING
	phone_flags &= ~PHONE_RINGING

/obj/item/smartphone/proc/decline_phone_call()
	SIGNAL_HANDLER

	SSphones.cancel_ring_timeout(incoming_sim_card)
	var/obj/item/smartphone/phone = incoming_sim_card.phone_weakref.resolve()
	SEND_SIGNAL(phone, COMSIG_PHONE_CALL_BUSY)
	secure_frequency = null
	dialed_number = null
	incoming_sim_card = null
	phone_flags &= ~PHONE_IN_CALL
	phone_flags &= ~PHONE_CALLING
	phone_flags &= ~PHONE_RINGING

/obj/item/smartphone/proc/accept_phone_call(mob/user)
	SSphones.cancel_ring_timeout(incoming_sim_card)
	secure_frequency = incoming_frequency
	phone_flags &= ~PHONE_RINGING
	initialize_phone_call(user)
	var/obj/item/smartphone/phone = incoming_sim_card.phone_weakref?.resolve()
	SEND_SIGNAL(phone, COMSIG_PHONE_CALL_ACCEPTED)

/obj/item/smartphone/proc/phone_call_declined(datum/source)
	SIGNAL_HANDLER

	balloon_alert(usr, "busy!")
	to_chat(usr, span_notice("The user you are attempting to call is currently busy. Please try again later."))
	ring_timeout()

/obj/item/smartphone/proc/ring(obj/item/sim_card/called_sim_card, obj/item/sim_card/caller_sim_card, established_frequency)
	SIGNAL_HANDLER

	say("RING RING RING")
	incoming_frequency = established_frequency
	incoming_sim_card = caller_sim_card
	phone_flags |= PHONE_RINGING

/obj/item/smartphone/proc/ring_timeout()
	SIGNAL_HANDLER

	if(secure_frequency)
		end_phone_call()
	incoming_frequency = null
	incoming_sim_card = null
	dialed_number = null
	phone_flags &= ~PHONE_IN_CALL
	phone_flags &= ~PHONE_RINGING
	phone_flags &= ~PHONE_CALLING
