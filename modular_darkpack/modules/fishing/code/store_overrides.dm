// mostly for crafting recipes
/obj/structure/retail/hardware_store/Initialize()
	. = ..()
	products_list += new /datum/data/vending_product("fifty sheets of glass", /obj/item/stack/sheet/glass/fifty, 500)
	products_list += new /datum/data/vending_product("fifty sheets of iron", /obj/item/stack/sheet/iron/fifty, 500)

/obj/structure/retail/camping/Initialize()
	. = ..()
	products_list += new /datum/data/vending_product("aquarium assembly kit", /obj/item/aquarium_kit, 200)
	products_list += new /datum/data/vending_product("aquarium upgrade kit", /obj/item/aquarium_upgrade, 150)
	products_list += new /datum/data/vending_product("aquarium fish food", /obj/item/reagent_containers/cup/fish_feed, 50)
	products_list += new /datum/data/vending_product("aquarium props box", /obj/item/storage/box/aquarium_props, 125)
	products_list += new /datum/data/vending_product("fishing lines kit", /obj/item/storage/box/fishing_lines/master, 50)
	products_list += new /datum/data/vending_product("fish cooler kit", /obj/item/cooler_kit, 150)
