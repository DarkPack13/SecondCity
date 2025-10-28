/obj/item/food/vampire/weed
	name = "leaf"
	desc = "Green and smelly..."
	icon_state = "weed"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	bite_consumption = 5
	tastes = list("cat piss" = 4, "weed" = 2)
	foodtypes = VEGETABLES
	food_reagents = list(/datum/reagent/drug/cannabis = 20, /datum/reagent/toxin/lipolicide = 20)
	eat_time = 10

/obj/item/food/vampire/weed/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 25, "weed", TRUE, -1, 7)
