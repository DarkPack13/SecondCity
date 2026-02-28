//SHOES

//SHOES

//SHOES

/obj/item/clothing/shoes/vampire
	name = "shoes"
	desc = "Comfortable-looking shoes."
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon_state = "shoes"
	gender = PLURAL
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/shoes/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 20, "shoes", FALSE)

/obj/item/clothing/shoes/vampire/brown
	icon_state = "shoes_brown"

/obj/item/clothing/shoes/vampire/white
	icon_state = "shoes_white"

/obj/item/clothing/shoes/vampire/jackboots
	name = "jackboots"
	desc = "Robust-looking boots."
	icon_state = "jackboots"

/obj/item/clothing/shoes/vampire/jackboots/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes)

/obj/item/clothing/shoes/vampire/jackboots/high
	name = "high boots"
	desc = "High boots. What else did you expect?"
	icon_state = "tall_boots"

/obj/item/clothing/shoes/vampire/jackboots/punk
	icon_state = "daboots"

/obj/item/clothing/shoes/vampire/jackboots/work
	icon_state = "jackboots_work"

/obj/item/clothing/shoes/vampire/sneakers
	name = "sneakers"
	desc = "Sport-looking sneakers."
	icon_state = "sneakers"

/obj/item/clothing/shoes/vampire/sneakers/red
	icon_state = "sneakers_red"

/obj/item/clothing/shoes/vampire/blackfur
	name = "black fur boots"
	desc = "A furry pair of black and white boots"
	icon_state = "furboots_black"

/obj/item/clothing/shoes/vampire/brownfur
	name = "brown fur boots"
	desc = "A furry pair of brown boots"
	icon_state = "furboots_brown"

/obj/item/clothing/shoes/vampire/pumped
	name = "knee-high sneakers"
	desc = "Sneakers from the popular brand Converts"
	icon_state = "pumped_up_kicks"

/obj/item/clothing/shoes/vampire/heels
	name = "heels"
	desc = "Rich-looking heels."
	icon_state = "heels"

/obj/item/clothing/shoes/vampire/heels/red
	icon_state = "heels_red"

/obj/item/clothing/shoes/vampire/businessscaly
	name = "scaly shoes"
	desc = "Shoes with scales."
	icon_state = "scales_shoes"

/obj/item/clothing/shoes/vampire/businessblack
	name = "black shoes"
	desc = "Classic black shoes."
	icon_state = "business_shoes"

/obj/item/clothing/shoes/vampire/businesstip
	name = "metal tip shoes"
	desc = "Shoes with a metal tip."
	icon_state = "metal_shoes"

