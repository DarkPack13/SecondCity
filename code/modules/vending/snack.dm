/obj/machinery/vending/snack
	name = "\improper Getmore Chocolate Corp"
	desc = "A snack machine courtesy of the Getmore Chocolate Corporation, based out of Mars."
	product_slogans = "Try our new nougat bar!;Twice the calories for half the price!"
	product_ads = "The healthiest!;Award-winning chocolate bars!;Mmm! So good!;Oh my god it's so juicy!;Have a snack.;Snacks are good for you!;Have some more Getmore!;Best quality snacks straight from mars.;We love chocolate!;Try our new jerky!"
	icon_state = "snack"
	panel_type = "panel2"
	light_mask = "snack-light-mask"
	// DARKPACK EDIT CHANGE START
	products = list(
		/obj/item/food/chocolatebar = 25,
		/obj/item/food/vampire/crisps = 20,
		/obj/item/reagent_containers/cup/glass/dry_ramen = 10,
		/obj/item/storage/box/gum = 10
	)
	// DARKPACK EDIT CHANGE END
	refill_canister = /obj/item/vending_refill/snack
	req_access = list(ACCESS_KITCHEN)
	default_price = PAYCHECK_CREW * 0.6
	extra_price = PAYCHECK_CREW
	payment_department = ACCOUNT_SRV
	allow_custom = TRUE

/obj/item/vending_refill/snack
	machine_name = "Getmore Chocolate Corp"

/obj/machinery/vending/snack/blue
	icon_state = "snackblue"
	allow_custom = FALSE

/obj/machinery/vending/snack/orange
	icon_state = "snackorange"
	allow_custom = FALSE

/obj/machinery/vending/snack/green
	icon_state = "snackgreen"
	allow_custom = FALSE

/obj/machinery/vending/snack/teal
	icon_state = "snackteal"
	allow_custom = FALSE
