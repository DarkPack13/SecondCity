#define TFN_PORTS_SUIT_ICONS \
	icon = 'modular_darkpack/modules/tfn_ports/icons/clothing.dmi'; \
	worn_icon = 'modular_darkpack/modules/tfn_ports/icons/worn.dmi'; \
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/tfn_ports/icons/onfloor.dmi')

// Bombers
/obj/item/clothing/suit/vampire/bomber
	name = "bomber jacket"
	desc = "A bomber jacket."
	icon_state = "bomber"
	TFN_PORTS_SUIT_ICONS

/obj/item/clothing/suit/vampire/bomber/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/bomber/retro
	name = "retro bomber jacket"
	desc = "A retro-style bomber jacket."
	icon_state = "retro_bomber"

/obj/item/clothing/suit/vampire/bomber/retro/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// Shawls
/obj/item/clothing/suit/vampire/shawl
	name = "black shawl"
	desc = "A long silk shawl, to be draped over the arms."
	icon_state = "shawl_black"
	TFN_PORTS_SUIT_ICONS

/obj/item/clothing/suit/vampire/shawl/white
	name = "white shawl"
	desc = "A long silk shawl, to be draped over the arms."
	icon_state = "shawl_white"

#undef TFN_PORTS_SUIT_ICONS
