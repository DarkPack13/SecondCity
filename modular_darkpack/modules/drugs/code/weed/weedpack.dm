/obj/item/weedpack
	name = "green package"
	desc = "Green and smelly..."
	icon_state = "package_weed"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	w_class = WEIGHT_CLASS_SMALL
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

/obj/item/weedpack/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 60, "weed_pack", TRUE, -1, 7)
