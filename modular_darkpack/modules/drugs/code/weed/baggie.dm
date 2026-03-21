/obj/item/reagent_containers/cup/glass/baggie/weed
	name = "green package"
	icon_state = "package_weed"
	list_reagents = list(/datum/reagent/drug/cannabis = 30)

/obj/item/reagent_containers/cup/glass/baggie/weed/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "cannabis", TRUE, -1, 4)
