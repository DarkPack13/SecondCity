/// Indestructable camera meant to dissuade LRP PD murderbones.
/obj/machinery/camera/police
	start_active = TRUE
	resistance_flags = parent_type::resistance_flags | INDESTRUCTIBLE

//Considering it is indestructible, this should ensure no one finds a way to disable it.
/obj/machinery/camera/wirecutter_act(mob/user, obj/item/tool)
	to_chat(user, span_notice("This camera's wires seem too well protected to disconnect."))
	return
