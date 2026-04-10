#define CLOTHING_NECK_ICONS \
	icon = 'modular_tfn/modules/clothing_additions/icons/clothing.dmi'; \
	worn_icon = 'modular_tfn/modules/clothing_additions/icons/worn.dmi'; \
	ONFLOOR_ICON_HELPER('modular_tfn/modules/clothing_additions/icons/onfloor.dmi')

/obj/item/clothing/neck/vampire/choker
	name = "black choker"
	desc = "A plain black choker. Popular with goths!"
	icon_state = "choker_black"
	CLOTHING_NECK_ICONS

/obj/item/clothing/neck/vampire/choker/metal
	name = "metallic choker"
	desc = "A silver, metallic choker. Scene chicks seem to dig it!"
	icon_state = "choker_metal"

/obj/item/clothing/neck/vampire/choker/leather
	name = "leather choker"
	desc = "A leather choker with a steel ring pendant."
	icon_state = "choker_leather"

/obj/item/clothing/neck/vampire/choker/silver
	name = "silver chain choker"
	desc = "A chain choker in tarnish-resistant, hypoallergenic silver. Hardcore."
	icon_state = "choker_silver"

/obj/item/clothing/neck/vampire/choker/fancy
	name = "fancy choker"
	desc = "A black choker with a gold ring pendant. A little classier than the alternatives."
	icon_state = "choker_fancy"
#undef CLOTHING_NECK_ICONS
