/obj/machinery/vending/coffee
	name = "\improper Solar's Best Hot Drinks"
	desc = "A vending machine which dispenses hot drinks."
	product_ads = "Have a drink!;Drink up!;It's good for you!;Would you like a hot joe?;I'd kill for some coffee!;The best beans in the galaxy.;Only the finest brew for you.;Mmmm. Nothing like a coffee.;I like coffee, don't you?;Coffee helps you work!;Try some tea.;We hope you like the best!;Try our new chocolate!;Admin conspiracies"
	// DARKPACK EDIT CHANGE START
	icon = 'modular_darkpack/modules/retail/icons/vendors_shops.dmi'
	icon_state = "coffee"
	icon_vend = null
	panel_type = null
	// DARKPACK EDIT CHANGE END
	products = list(
		/obj/item/reagent_containers/cup/glass/coffee/vampire = 10, // DARKPACK EDIT CHANGE
		/obj/item/reagent_containers/cup/glass/coffee/vampire/robust = 5, // DARKPACK EDIT CHANGE
		/obj/item/reagent_containers/cup/glass/mug/tea = 6,
		/obj/item/reagent_containers/cup/glass/mug/coco = 3,
	)
	contraband = list(
		/obj/item/reagent_containers/cup/glass/ice = 12,
	)
	refill_canister = /obj/item/vending_refill/coffee
	default_price = PAYCHECK_LOWER
	extra_price = PAYCHECK_CREW
	payment_department = ACCOUNT_SRV
	//light_mask = "coffee-light-mask" // DARKPACK EDIT REMOVAL
	//light_color = COLOR_DARK_MODERATE_ORANGE // DARKPACK EDIT REMOVAL
	allow_custom = TRUE

// DARKPACK EDIT ADD START
/obj/machinery/vending/coffee/private
	desc = "An employee only vending machine. I love coffee in my coffee hole."
	req_access = null
	onstation = FALSE
	all_products_free = TRUE
// DARKPACK EDIT ADD END

/obj/item/vending_refill/coffee
	machine_name = "Solar's Best Hot Drinks"
	icon_state = "refill_joe"
