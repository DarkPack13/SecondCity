/obj/machinery/radio_tranceiver
	name = "radio transceiver"
	desc = "A machine used for connecting and managing radios on its designated network."
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "walkietalkie"
	density = TRUE
	pass_flags = PASSTABLE
	pass_flags_self = LETPASSTHROW
	var/radio_network = "Unnamed Network"
	var/radio_frequency = FREQ_COMMON
	var/list/connected_radios = list()

/obj/machinery/radio_tranceiver/Initialize(mapload)
	. = ..()
	register_context()

/obj/machinery/radio_tranceiver/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!held_item)
		context[SCREENTIP_CONTEXT_LMB] = "Open Radio Management"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_LMB] = anchored ? "Unsecure" : "Secure"
		return CONTEXTUAL_SCREENTIP_SET
	return ..()

/obj/machinery/radio_tranceiver/examine(mob/user)
	. = ..()
	. += span_notice("It is currently connected and managing \the [radio_network].")

/obj/machinery/radio_tranceiver/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/radio/headset/darkpack))
		return ..()

	if(user.st_get_stat(STAT_TECHNOLOGY) < 1)
		to_chat(user, span_warning("You don't know how to operate this!"))
		return ITEM_INTERACT_FAILURE

	var/obj/item/radio/headset/darkpack/radio = tool
	if(radio.radio_id)
		if("[radio.radio_id]" in connected_radios)
			to_chat(user, span_notice("You unlink the [radio] from the [radio_network]."))
			leave_network(radio)
			return ITEM_INTERACT_SUCCESS
		else
			to_chat(user, span_notice("You can't link the [radio] to the [radio_network] because it is connected to the [radio.radio_network]!"))
			return ITEM_INTERACT_SUCCESS
	else
		var/input_number = tgui_input_number(user = user, message = "Set Radio ID", title = "Enter a numerical ID to use for this network.", max_value = 999, min_value = 1, round_value = TRUE)
		if(!input_number)
			return ITEM_INTERACT_FAILURE
		if("[input_number]" in connected_radios)
			to_chat(user, span_warning("A radio with that ID is already connected to this network!"))
			return ITEM_INTERACT_FAILURE
		join_network(radio, input_number)
		to_chat(user, span_notice("You link the [radio] to the [radio_network]."))
	return ITEM_INTERACT_SUCCESS

/obj/machinery/radio_tranceiver/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	balloon_alert(user, "[anchored ? "un" : ""]securing...")
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 1 TURNS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, vary = TRUE)
		balloon_alert(user, "[anchored ? "un" : ""]secured")
		set_anchored(!anchored)
	return TRUE

/obj/machinery/radio_tranceiver/proc/join_network(obj/item/radio/headset/darkpack/connected_radio, radio_id)
	connected_radio.radio_id = radio_id
	connected_radio.radio_network = radio_network
	connected_radio.set_frequency(radio_frequency)
	var/datum/weakref/radio_weakref = WEAKREF(connected_radio)
	connected_radios["[radio_id]"] = radio_weakref

/obj/machinery/radio_tranceiver/proc/leave_network(obj/item/radio/headset/darkpack/disconnected_radio)
	disconnected_radio.radio_network = null
	disconnected_radio.set_frequency(FREQ_COMMON)
	connected_radios -= "[disconnected_radio.radio_id]"
	disconnected_radio.radio_id = null

/obj/machinery/radio_tranceiver/police
	radio_network = "Police Network"
	radio_frequency = FREQ_POLICE

/obj/machinery/radio_tranceiver/clinic
	radio_network = "Clinic Network"
	radio_frequency = FREQ_CLINIC

/obj/machinery/radio_tranceiver/camarilla
	radio_network = "Tower Network"
	radio_frequency = FREQ_CAMARILLA

/obj/machinery/radio_tranceiver/anarch
	radio_network = "Bar Network"
	radio_frequency = FREQ_ANARCH

/obj/machinery/radio_tranceiver/endron
	radio_network = "Endron Network"
	radio_frequency = FREQ_ENDRON
