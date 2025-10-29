//SanFran community garden stuff
/obj/structure/closet/crate/wooden/communitygardens/tools
	name = "community garden tools"
	desc = null

/obj/structure/closet/crate/wooden/communitygardens/tools/Initialize(mapload)
	. = ..()
	if(isnull(desc))
		desc = "It's marked with the [CITY_NAME] City Council stamp

/obj/structure/closet/crate/wooden/communitygardens/tools/PopulateContents()
	. = ..()
	new /obj/item/storage/bag/plants(src)
	new /obj/item/reagent_containers/glass/bottle/nutrient/rh(src)
	new /obj/item/reagent_containers/spray/weedspray(src)
	new /obj/item/reagent_containers/spray/pestspray(src)
	new	/obj/item/cultivator(src)
	new	/obj/item/clothing/gloves/botanic_leather(src)
	new	/obj/item/reagent_containers/glass/wateringcan(src)

/obj/structure/closet/crate/wooden/communitygardens/seeds
	name = "community garden seeds"
	desc = null

/obj/structure/closet/crate/wooden/communitygardens/seeds/Initialize(mapload)
	. = ..()
	if(isnull(desc))
		desc = "It's marked with the [CITY_NAME] City Council stamp

/obj/structure/closet/crate/wooden/communitygardens/seeds/PopulateContents()
	. = ..()
	new	/obj/item/seeds/cabbage(src)
	new	/obj/item/seeds/peas(src)
	new	/obj/item/seeds/potato(src)
	new	/obj/item/seeds/soya(src)
	new	/obj/item/seeds/tomato(src)
