// Use /obj/structure/retail/gas_station unless you really only want junkfood
/obj/structure/retail/junkfood_menu
	desc = "Purchase junkfood and crap."
	products_list = list(
		new /datum/data/vending_product("chocolate bar", /obj/item/food/chocolatebar),
		new /datum/data/vending_product("chips", /obj/item/food/chips),
		new /datum/data/vending_product("water bottle", /obj/item/reagent_containers/cup/glass/vampirewater),
		new /datum/data/vending_product("soda can", /obj/item/reagent_containers/cup/soda_cans/vampiresoda),
		new /datum/data/vending_product("two liter cola bottle", /obj/item/reagent_containers/cup/glass/vampirecola),
		new /datum/data/vending_product("cola can", /obj/item/reagent_containers/cup/soda_cans/vampirecola),
		new /datum/data/vending_product("summer thaw", /obj/item/reagent_containers/cup/soda_cans/summer_thaw),
		new /datum/data/vending_product("milk", /obj/item/reagent_containers/condiment/milk,	5),
		new /datum/data/vending_product("beer bottle", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire,	10),
		new /datum/data/vending_product("blue stripe", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire/blue_stripe, 8),
		new /datum/data/vending_product("candle pack", /obj/item/storage/fancy/candle_box,	12),
		new /datum/data/vending_product("bruise pack", /obj/item/stack/medical/bruise_pack, 100),
		new /datum/data/vending_product("respirator", /obj/item/clothing/mask/vampire,	35)
	)
