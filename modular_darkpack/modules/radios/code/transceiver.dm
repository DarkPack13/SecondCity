/obj/machinery/radio_tranceiver
	name = "radio transceiver"
	desc = "A machine used for connecting and managing radios on its designated network."
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "walkietalkie"
	var/radio_network = "Unnamed Network"
	var/list/connected_radios = list()

/obj/machinery/radio_tranceiver/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/radio/headset/darkpack))
		return ..()

	var/obj/item/radio/headset/darkpack/radio = tool
	if(radio.radio_id)
		if(radio.radio_id in connected_radios)
			to_chat(user, span_notice("You unlink \the [radio] from the [radio_network]."))
			connected_radios -= radio.radio_id
			radio.radio_id = null
			radio.radio_network = null
			return ITEM_INTERACT_SUCCESS
		else
			to_chat(user, span_notice("You can't link \the [radio] to the [radio_network] because it is already connected to another network!"))
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
		connected_radios += radio[input_number]
		to_chat(user, span_notice("You link \the [radio] to the [radio_network]."))
	return ITEM_INTERACT_SUCCESS
