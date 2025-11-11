/obj/machinery/vending/cola
	icon_state = "cola_red"
	icon = 'modular_darkpack/modules/retail/icons/vendors_shops.dmi'
	light_mask = "cola-light-mask"
	products = list(
		/obj/item/reagent_containers/cup/soda_cans/vampirecola = 20,
		/obj/item/reagent_containers/cup/soda_cans/vampirecola/blue = 10,
		// /obj/item/reagent_containers/cup/glass/waterbottle = 10, // TODO: Resprite
	)
	contraband = list()
	premium = list()

/obj/machinery/vending/cola/blue
	icon_state = "cola_blue"
	light_mask = "cola-light-mask"
	light_color = COLOR_MODERATE_BLUE

/obj/machinery/vending/cola/black
	icon_state = "cola_black"
	light_mask = "cola-light-mask"

/obj/machinery/vending/cola/red
	icon_state = "cola_red"
	light_mask = "cola-light-mask"
	light_color = COLOR_DARK_RED

/obj/machinery/vending/cola/space_up
	icon_state = "cola_red"
	light_mask = "cola-light-mask"
	light_color = COLOR_DARK_RED

// Bloodlines Refrence
/obj/machinery/vending/cola/starkist
	name = "\improper 13 Vitamins Vendor"
	desc = "13 stimulants in every bottle!!!"
	icon_state = "thirteen"
	light_mask = "thirteen-light-mask"
	light_color = COLOR_YELLOW

/obj/machinery/vending/cola/sodie
	icon_state = "cola_red"
	light_mask = "cola-light-mask"
	light_color = COLOR_DARK_RED

// Bloodlines Refrence
/obj/machinery/vending/cola/pwr_game
	name = "\improper Liquid Demon Seed Vendor"
	desc = "Slobber it DOWN!!"
	icon_state = "demon_seed"
	light_mask = "demon_seed-light-mask"

/obj/machinery/vending/cola/shamblers
	name = "\improper Yumco Softdrinks"
	icon_state = "yumco"
	light_mask = "yumco-light-mask"
	light_color = COLOR_YELLOW
