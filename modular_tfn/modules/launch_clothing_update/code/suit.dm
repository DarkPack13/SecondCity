#define LCU_SUIT_ICONS \
	icon = 'modular_tfn/modules/launch_clothing_update/icons/clothing.dmi'; \
	worn_icon = 'modular_tfn/modules/launch_clothing_update/icons/worn.dmi'; \
	ONFLOOR_ICON_HELPER('modular_tfn/modules/launch_clothing_update/icons/onfloor.dmi')

/obj/item/clothing/suit/vampire
	abstract_type = /obj/item/clothing/suit/vampire

// Jackets
/obj/item/clothing/suit/vampire/jacket3
	name = "stylish jacket"
	desc = "A stylish jacket."
	icon_state = "jacket3"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/jacket1_cut
	name = "cut black leather jacket"
	desc = "A black leather jacket."
	icon_state = "jacket1_cut"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/jacket2_cut
	name = "cut brown leather jacket"
	desc = "A brown leather jacket."
	icon_state = "jacket2_cut"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/jacket3_cut
	name = "cut stylish jacket"
	desc = "A stylish jacket."
	icon_state = "jacket3_cut"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/gentlecoat
	name = "gentleman's coat"
	desc = "A refined gentleman's coat."
	icon_state = "gentlecoat"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/detective
	name = "detective coat"
	desc = "A classic detective's coat."
	icon_state = "detective"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/detective2
	name = "detective jacket"
	desc = "A detective's jacket."
	icon_state = "detective2"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/letterman
	name = "letterman jacket"
	desc = "A classic letterman jacket."
	icon_state = "letterman_c"
	LCU_SUIT_ICONS

// Military Jackets
/obj/item/clothing/suit/vampire/militaryjacket
	abstract_type = /obj/item/clothing/suit/vampire/militaryjacket
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/militaryjacket/white
	name = "white military jacket"
	desc = "A white military-style jacket."
	icon_state = "militaryjacket_white"

/obj/item/clothing/suit/vampire/militaryjacket/tan
	name = "tan military jacket"
	desc = "A tan military-style jacket."
	icon_state = "militaryjacket_tan"

/obj/item/clothing/suit/vampire/militaryjacket/navy
	name = "navy military jacket"
	desc = "A navy military-style jacket."
	icon_state = "militaryjacket_navy"

/obj/item/clothing/suit/vampire/militaryjacket/grey
	name = "grey military jacket"
	desc = "A grey military-style jacket."
	icon_state = "militaryjacket_grey"

/obj/item/clothing/suit/vampire/militaryjacket/black
	name = "black military jacket"
	desc = "A black military-style jacket."
	icon_state = "militaryjacket_black"

// Leather Jackets
/obj/item/clothing/suit/vampire/leather_jacket
	name = "leather jacket"
	desc = "A leather jacket."
	icon_state = "leather_jacket"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/leather_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/leather_jacket_sleeveless
	name = "sleeveless leather jacket"
	desc = "A sleeveless leather jacket."
	icon_state = "leather_jacket_sleeveless"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/leather_jacket_sleeveless/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// Brown Jackets
/obj/item/clothing/suit/vampire/brown_jacket
	name = "brown jacket"
	desc = "A brown jacket."
	icon_state = "brown_jacket"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/brown_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/brown_jacket_sleeveless
	name = "sleeveless brown jacket"
	desc = "A sleeveless brown jacket."
	icon_state = "brown_jacket_sleeveless"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/brown_jacket_sleeveless/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// Bombers
/obj/item/clothing/suit/vampire/bomber
	name = "bomber jacket"
	desc = "A bomber jacket."
	icon_state = "bomber"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/bomber/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/retro_bomber
	name = "retro bomber jacket"
	desc = "A retro-style bomber jacket."
	icon_state = "retro_bomber"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/retro_bomber/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// Colored Hoodies
/obj/item/clothing/suit/vampire/hoodie
	abstract_type = /obj/item/clothing/suit/vampire/hoodie
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/hoodie/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/hoodie/grey
	name = "grey hoodie"
	desc = "A grey hoodie."
	icon_state = "grey_hoodie"

/obj/item/clothing/suit/vampire/hoodie/black
	name = "black hoodie"
	desc = "A black hoodie."
	icon_state = "black_hoodie"

/obj/item/clothing/suit/vampire/hoodie/red
	name = "red hoodie"
	desc = "A red hoodie."
	icon_state = "red_hoodie"

/obj/item/clothing/suit/vampire/hoodie/blue
	name = "blue hoodie"
	desc = "A blue hoodie."
	icon_state = "blue_hoodie"

/obj/item/clothing/suit/vampire/hoodie/orange
	name = "orange hoodie"
	desc = "An orange hoodie."
	icon_state = "orange_hoodie"

/obj/item/clothing/suit/vampire/hoodie/pink
	name = "pink hoodie"
	desc = "A pink hoodie."
	icon_state = "pink_hoodie"

// Puffer
/obj/item/clothing/suit/vampire/pufferjacket
	name = "puffer jacket"
	desc = "A puffer jacket."
	icon_state = "pufferjacket"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/puffervest
	name = "puffer vest"
	desc = "A puffer vest."
	icon_state = "puffervest"
	LCU_SUIT_ICONS

// Varsity
/obj/item/clothing/suit/vampire/varsity
	name = "varsity jacket"
	desc = "A varsity jacket."
	icon_state = "varsity"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/varsity/purple
	name = "purple varsity jacket"
	desc = "A purple varsity jacket."
	icon_state = "varsity_purple"

// Track Jackets
/obj/item/clothing/suit/vampire/trackjacket
	abstract_type = /obj/item/clothing/suit/vampire/trackjacket
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/trackjacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/trackjacket/grey
	name = "grey track jacket"
	desc = "A grey track jacket."
	icon_state = "trackjacket"

/obj/item/clothing/suit/vampire/trackjacket/blue
	name = "blue track jacket"
	desc = "A blue track jacket."
	icon_state = "trackjacketblue"

/obj/item/clothing/suit/vampire/trackjacket/green
	name = "green track jacket"
	desc = "A green track jacket."
	icon_state = "trackjacketgreen"

/obj/item/clothing/suit/vampire/trackjacket/red
	name = "red track jacket"
	desc = "A red track jacket."
	icon_state = "trackjacketred"

/obj/item/clothing/suit/vampire/trackjacket/white
	name = "white track jacket"
	desc = "A white track jacket."
	icon_state = "trackjacketwhite"

// Department Jackets
/obj/item/clothing/suit/vampire/dep_jacket
	abstract_type = /obj/item/clothing/suit/vampire/dep_jacket
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/dep_jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/dep_jacket/engi
	name = "engineering jacket"
	desc = "An engineering jacket."
	icon_state = "engi_dep_jacket"

/obj/item/clothing/suit/vampire/dep_jacket/sec
	name = "security guard jacket"
	desc = "A security guard jacket."
	icon_state = "sec_dep_jacket"

/obj/item/clothing/suit/vampire/dep_jacket/med
	name = "medical jacket"
	desc = "A medical jacket."
	icon_state = "med_dep_jacket"

/obj/item/clothing/suit/vampire/dep_jacket/supply
	name = "supply department jacket"
	desc = "A supply department jacket."
	icon_state = "supply_dep_jacket"

/obj/item/clothing/suit/vampire/dep_jacket/grey
	name = "grey department jacket"
	desc = "A grey department jacket."
	icon_state = "grey_dep_jacket"

/obj/item/clothing/suit/vampire/dep_jacket/blue
	name = "blue department jacket"
	desc = "A blue department jacket."
	icon_state = "blue_dep_jacket"

// Park Jackets
// NOTE: parkas are subtypes of suit/hooded/hoodie which uses darkpack icons,
// so each parka must explicitly declare LCU icons.

/obj/item/clothing/suit/hooded/hoodie/parka_yellow
	name = "yellow parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "yellowpark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_yellow
	LCU_SUIT_ICONS

/obj/item/clothing/head/hooded/hood_hood/parka_yellow
	name = "yellow parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "yellowpark_hood"
	icon = 'modular_tfn/modules/launch_clothing_update/icons/clothing.dmi'
	worn_icon = 'modular_tfn/modules/launch_clothing_update/icons/worn.dmi'

/obj/item/clothing/suit/hooded/hoodie/parka_red
	name = "red parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "redpark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_red
	LCU_SUIT_ICONS

/obj/item/clothing/head/hooded/hood_hood/parka_red
	name = "red parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "redpark_hood"
	icon = 'modular_tfn/modules/launch_clothing_update/icons/clothing.dmi'
	worn_icon = 'modular_tfn/modules/launch_clothing_update/icons/worn.dmi'

/obj/item/clothing/suit/hooded/hoodie/parka_purple
	name = "purple parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "purplepark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_purple
	LCU_SUIT_ICONS

/obj/item/clothing/head/hooded/hood_hood/parka_purple
	name = "purple parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "purplepark_hood"
	icon = 'modular_tfn/modules/launch_clothing_update/icons/clothing.dmi'
	worn_icon = 'modular_tfn/modules/launch_clothing_update/icons/worn.dmi'

/obj/item/clothing/suit/hooded/hoodie/parka_green
	name = "green parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "greenpark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_green
	LCU_SUIT_ICONS

/obj/item/clothing/head/hooded/hood_hood/parka_green
	name = "green parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "greenpark_hood"
	icon = 'modular_tfn/modules/launch_clothing_update/icons/clothing.dmi'
	worn_icon = 'modular_tfn/modules/launch_clothing_update/icons/worn.dmi'

/obj/item/clothing/suit/hooded/hoodie/parka_blue
	name = "blue parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "bluepark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_blue
	LCU_SUIT_ICONS

/obj/item/clothing/head/hooded/hood_hood/parka_blue
	name = "blue parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "bluepark_hood"
	icon = 'modular_tfn/modules/launch_clothing_update/icons/clothing.dmi'
	worn_icon = 'modular_tfn/modules/launch_clothing_update/icons/worn.dmi'

/obj/item/clothing/suit/hooded/hoodie/parka_vintage
	name = "vintage parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "vintagepark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_vintage
	LCU_SUIT_ICONS

/obj/item/clothing/head/hooded/hood_hood/parka_vintage
	name = "vintage parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "vintagepark_hood"
	icon = 'modular_tfn/modules/launch_clothing_update/icons/clothing.dmi'
	worn_icon = 'modular_tfn/modules/launch_clothing_update/icons/worn.dmi'

// Suit Jackets
/obj/item/clothing/suit/vampire/suitjacket
	abstract_type = /obj/item/clothing/suit/vampire/suitjacket
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/suitjacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/vampire/suitjacket/blue
	name = "blue suit jacket"
	desc = "A blue suit jacket."
	icon_state = "suitjacket_blue"

/obj/item/clothing/suit/vampire/suitjacket/purp
	name = "purple suit jacket"
	desc = "A purple suit jacket."
	icon_state = "suitjacket_purp"

/obj/item/clothing/suit/vampire/suitjacket/black
	name = "black suit jacket"
	desc = "A black suit jacket."
	icon_state = "suitjacket_black"

/obj/item/clothing/suit/vampire/suitjacket/tan
	name = "tan suit jacket"
	desc = "A tan suit jacket."
	icon_state = "suitjacket_tan"

/obj/item/clothing/suit/vampire/suitjacket/charcoal
	name = "charcoal suit jacket"
	desc = "A charcoal suit jacket."
	icon_state = "suitjacket_charcoal"

/obj/item/clothing/suit/vampire/suitjacket/navy
	name = "navy suit jacket"
	desc = "A navy suit jacket."
	icon_state = "suitjacket_navy"

/obj/item/clothing/suit/vampire/suitjacket/burgundy
	name = "burgundy suit jacket"
	desc = "A burgundy suit jacket."
	icon_state = "suitjacket_burgundy"

/obj/item/clothing/suit/vampire/suitjacket/checkered
	name = "checkered suit jacket"
	desc = "A checkered suit jacket."
	icon_state = "suitjacket_checkered"

// Shawls
/obj/item/clothing/suit/vampire/shawl_black
	name = "black shawl"
	desc = "A long silk shawl, to be draped over the arms."
	icon_state = "shawl_black"
	LCU_SUIT_ICONS

/obj/item/clothing/suit/vampire/shawl_white
	name = "white shawl"
	desc = "A long silk shawl, to be draped over the arms."
	icon_state = "shawl_white"
	LCU_SUIT_ICONS

#undef LCU_SUIT_ICONS
