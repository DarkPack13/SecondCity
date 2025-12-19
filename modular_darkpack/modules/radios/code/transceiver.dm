/obj/machinery/radio_tranceiver
	name = "radio transceiver"
	desc = "A machine used for connecting and managing radios on its designated network."
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "walkietalkie"
	density = TRUE
	pass_flags = PASSTABLE
	pass_flags_self = LETPASSTHROW
	var/radio_network = "Unnamed Network"
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
			connected_radios -= "[radio.radio_id]"
			radio.radio_id = null
			radio.radio_network = null
			return ITEM_INTERACT_SUCCESS
		else
			to_chat(user, span_notice("You can't link the [radio] to the [radio_network] because it is connected to the [radio.radio_network]!"))
			return ITEM_INTERACT_SUCCESS
	else
		var/input_number = tgui_input_number(user = user, message = "Set Radio ID", title = "Enter a numerical ID to use for this network.", max_value = 999, min_value = 1, round_value = TRUE)
		if(!input_number)
			return ITEM_INTERACT_FAILURE
		if(input_number in connected_radios)
			to_chat(user, span_warning("A radio with that ID is already connected to this network!"))
			return ITEM_INTERACT_FAILURE
		radio.radio_id = input_number
		radio.radio_network = radio_network
		var/datum/weakref/radio_weakref = WEAKREF(radio)
		connected_radios["[input_number]"] = radio_weakref
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
