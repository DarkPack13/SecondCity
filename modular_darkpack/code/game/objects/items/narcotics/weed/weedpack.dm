/obj/item/weedpack
	name = "green package"
	desc = "Green and smelly..."
	icon_state = "package_weed"
	icon = 'modular_darkpack/icons/items.dmi'
	w_class = WEIGHT_CLASS_SMALL
	onflooricon = 'modular_darkpack/icons/onfloor.dmi'

/obj/item/weedpack/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 150, "weed_pack", TRUE, -1, 7)
