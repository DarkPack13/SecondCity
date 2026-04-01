//GLASSES

//GLASSES

//GLASSES

/obj/item/clothing/glasses/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/glasses/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "glasses", FALSE)

/obj/item/clothing/glasses/vampire/yellow
	name = "yellow aviators"
	desc = "For working in dark environment."
	icon_state = "yellow"
	inhand_icon_state = "glasses"

/obj/item/clothing/glasses/vampire/red
	name = "red aviators"
	desc = "For working in dark environment."
	icon_state = "redg"
	inhand_icon_state = "glasses"

/obj/item/clothing/glasses/vampire/sun
	name = "sunglasses"
	desc = "For looking cool."
	icon_state = "sun"
	inhand_icon_state = "glasses"
	tint = 1
	flash_protect = FLASH_PROTECTION_FLASH

/obj/item/clothing/glasses/vampire/perception
	name = "reading glasses"
	desc = "For reading books."
	icon_state = "perception"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/vampire/veil
	name = "white veil"
	desc = "A white lace veil that covers the eyes."
	icon_state = "white_veil"

/obj/item/clothing/glasses/vampire/veil/black
	name = "black veil"
	desc = "A dark veil that obscures the wearer's face."
	icon_state = "black_veil"
