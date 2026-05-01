/obj/item/reagent_containers/cup/watering_can/metal
	icon = 'modular_darkpack/modules/drugs/icons/items.dmi'
	icon_state = "bailer"

//SanFran community garden stuff
/obj/structure/closet/crate/wooden/communitygardens
	desc = null
	abstract_type = /obj/structure/closet/crate/wooden/communitygardens

/obj/structure/closet/crate/wooden/communitygardens/Initialize(mapload)
	. = ..()
	if(isnull(desc))
		desc = "It's marked with the [CITY_NAME] City Council stamp"

/obj/structure/closet/crate/wooden/communitygardens/tools
	name = "community garden tools"

/obj/structure/closet/crate/wooden/communitygardens/tools/PopulateContents()
	new /obj/item/storage/bag/plants(src)
	new /obj/item/clothing/gloves/botanic_leather(src)
	new /obj/item/reagent_containers/cup/bottle/nutrient/rh(src)
	new /obj/item/reagent_containers/spray/weedspray(src)
	new /obj/item/reagent_containers/spray/pestspray(src)
	new /obj/item/cultivator/rake(src)
	new /obj/item/hatchet/wooden(src)
	new /obj/item/secateurs(src)
	new /obj/item/reagent_containers/cup/watering_can/metal(src)
	new /obj/item/soil_sack(src)
	new /obj/item/soil_sack(src)

/obj/structure/closet/crate/wooden/communitygardens/seeds
	name = "community garden seeds"

/obj/structure/closet/crate/wooden/communitygardens/seeds/PopulateContents()
	new /obj/item/seeds/cabbage(src)
	new /obj/item/seeds/peas(src)
	new /obj/item/seeds/potato(src)
	new /obj/item/seeds/soya(src)
	new /obj/item/seeds/tomato(src)
