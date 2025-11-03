// kinda equivlent to /obj/item/reagent_containers/cup/glass/drinkingglass
/obj/item/reagent_containers/cup/glass/drinkingglass/collins_glass
	name = "collins glass"
	icon_state = "collins_glass"
	icon = 'modular_darkpack/modules/food/icons/drinking_glass.dmi'
	fill_icon_state = "collinsglass"
	fill_icon = 'modular_darkpack/modules/food/icons/reagentfillings.dmi'

// kinda equivlent to /obj/item/reagent_containers/cup/glass/drinkingglass/shotglass
/obj/item/reagent_containers/cup/glass/drinkingglass/vodka_shot
	name = "shot glass"
	icon_state = "vodka_shot"
	icon = 'modular_darkpack/modules/food/icons/drinking_glass.dmi'
	fill_icon_state = "vodkashot"
	fill_icon = 'modular_darkpack/modules/food/icons/reagentfillings.dmi'
	fill_icon_thresholds = list(5, 10, 15)
	amount_per_transfer_from_this = 15
	volume = 15
	custom_materials = list(/datum/material/glass=70)

/obj/item/reagent_containers/cup/glass/drinkingglass/martini_glass
	name = "martini glass"
	icon_state = "martini_glass"
	icon = 'modular_darkpack/modules/food/icons/drinking_glass.dmi'
	fill_icon_state = "martiniglass"
	fill_icon = 'modular_darkpack/modules/food/icons/reagentfillings.dmi'
	fill_icon_thresholds = list(5, 10, 15)
	amount_per_transfer_from_this = 15
	volume = 15
	custom_materials = list(/datum/material/glass=70)

/obj/item/reagent_containers/cup/glass/drinkingglass/whiskey_shot
	name = "whiskey shot"
	icon_state = "whiskey_shot"
	icon = 'modular_darkpack/modules/food/icons/drinking_glass.dmi'
	fill_icon_state = "whiskeyshot"
	fill_icon = 'modular_darkpack/modules/food/icons/reagentfillings.dmi'
	fill_icon_thresholds = list(10, 20, 30)
	volume = 30
	custom_materials = list(/datum/material/glass=100)

/obj/item/reagent_containers/cup/glass/drinkingglass/wine_glass
	name = "wine glass"
	icon_state = "wine_glass"
	icon = 'modular_darkpack/modules/food/icons/drinking_glass.dmi'
	fill_icon_state = "wineglass"
	fill_icon = 'modular_darkpack/modules/food/icons/reagentfillings.dmi'
	fill_icon_thresholds = list(5, 15, 30, 40, 50)
	volume = 50
	custom_materials = list(/datum/material/glass=500)

/obj/item/reagent_containers/cup/glass/drinkingglass/pint
	name = "pint glass"
	icon_state = "pint"
	icon = 'modular_darkpack/modules/food/icons/drinking_glass.dmi'
	fill_icon_state = "pint"
	fill_icon = 'modular_darkpack/modules/food/icons/reagentfillings.dmi'
	fill_icon_thresholds = list(5, 15, 30, 50, 75, 90)

	volume = 90
	custom_materials = list(/datum/material/glass=1000)
