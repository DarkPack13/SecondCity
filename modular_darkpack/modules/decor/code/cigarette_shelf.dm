/obj/machinery/vending/cigarette/shelf
	name = "cigarette shelf"
	desc = "Every variety, except for the one you really like."
	icon = 'modular_darkpack/modules/decor/icons/cigarette_shelf.dmi' // TODO: add behavior for swapping to the empty icon
	icon_state = "ciggies1"
	base_icon_state = "ciggies"
	tiltable = FALSE
	panel_type = "panel22"
	light_mask = "ciggies-light-mask"
	light_color = COLOR_WHITE

/obj/machinery/vending/cigarette/shelf/Initialize(mapload)
	. = ..()
	if(icon_state == src::icon_state)
		icon_state = "[base_icon_state][rand(1,3)]"
