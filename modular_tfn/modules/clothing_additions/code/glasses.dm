#define CLOTHING_GLASSES_ICONS \
	icon = 'modular_tfn/modules/clothing_additions/icons/clothing.dmi'; \
	worn_icon = 'modular_tfn/modules/clothing_additions/icons/worn.dmi'; \
	ONFLOOR_ICON_HELPER('modular_tfn/modules/clothing_additions/icons/onfloor.dmi')

//Aviators
/obj/item/clothing/glasses/vampire/aviator
	name = "aviators"
	desc = "Thick framed aviators."
	icon_state = "aviator"
	inhand_icon_state = "sunglasses"
	CLOTHING_GLASSES_ICONS

/obj/item/clothing/glasses/vampire/aviator/green
	name = "green aviators"
	desc = "Thick-framed aviators, now in green."
	icon_state = "aviator_green"

/obj/item/clothing/glasses/vampire/aviator/blue
	name = "blue aviators"
	desc = "Thick-framed aviators, now in blue."
	icon_state = "aviator_blue"

//Sunglassses
/obj/item/clothing/glasses/vampire/sun/oversized
	name = "oversized sunglasses"
	desc = "Oversized visor sunglasses. Extra cool at night."
	icon_state = "sun_oversized"
	inhand_icon_state = "sunglasses"
	CLOTHING_GLASSES_ICONS

/obj/item/clothing/glasses/vampire/sun/thin
	name = "thin sunglasses"
	desc = "A pair of thin-framed sunglasses."
	icon_state = "sun_thin"
	inhand_icon_state = "sunglasses"
	CLOTHING_GLASSES_ICONS

//Perception Glasses
/obj/item/clothing/glasses/vampire/perception/green
	name = "green prescription glasses"
	desc = "Prescription glasses with thick, green plastic frames."
	icon_state = "perception_green"
	inhand_icon_state = "glasses"
	CLOTHING_GLASSES_ICONS

/obj/item/clothing/glasses/vampire/perception/retro
	name = "retro glasses"
	desc = "Prescription glasses straight out of the 1980s."
	icon_state = "perception_retro"
	CLOTHING_GLASSES_ICONS

/obj/item/clothing/glasses/vampire/perception/metal
	name = "metal-framed prescription glasses"
	desc = "Prescribed glasses with a thick metal frame."
	icon_state = "perception_metal"
	CLOTHING_GLASSES_ICONS

//Misc Glasses
/obj/item/clothing/glasses/vampire/misc/bicolor
	name = "bicolor glasses"
	desc = "These let you see the whole world in 3D."
	icon_state = "bicolor"
	inhand_icon_state = "glasses"
	CLOTHING_GLASSES_ICONS

/obj/item/clothing/glasses/vampire/misc/safety
	name = "safety goggles"
	desc = "Always wear personal protective equipment when sulking."
	icon_state = "safety_goggles"
	inhand_icon_state = "glasses"
	CLOTHING_GLASSES_ICONS

//Eyepatches
/obj/item/clothing/glasses/vampire/misc/eyepatch
	name = "right eyepatch"
	desc = "Black and menacing."
	icon_state = "eyepatch"
	CLOTHING_GLASSES_ICONS

/obj/item/clothing/glasses/vampire/misc/eyepatch/left
	name = "left eyepatch"
	desc = "Black and menacing."
	icon_state = "eyepatch_left"

/obj/item/clothing/glasses/vampire/misc/eyepatch/medical
	name = "right medical eyepatch"
	desc = "The less menacing option."
	icon_state = "eyepatch_medical"

/obj/item/clothing/glasses/vampire/misc/eyepatch/medical_left
	name = "left medical eyepatch"
	desc = "The less menacing option."
	icon_state = "eyepatch_medical_left"

//Veils
/obj/item/clothing/glasses/vampire/misc/veil
	name = "white veil"
	desc = "A white lace veil that covers the eyes."
	icon_state = "veil"
	CLOTHING_GLASSES_ICONS

/obj/item/clothing/glasses/vampire/misc/veil/black
	name = "black veil"
	desc = "A black lace veil that obscures the wearer's face."
	icon_state = "veil_black"

#undef CLOTHING_GLASSES_ICONS
