/datum/data/vending_product
	var/icon_dimension

/datum/data/vending_product/New(name = "product", path, price, amount = -1)
	src.name = name
	src.product_path = path
	src.price = price
	src.amount = amount

	var/obj/item/item = product_path
	if(!item)
		CRASH("Retail product equipment path of [product_path] is not a valid path!")

	if(!price)
		src.price = item.custom_price || item.custom_premium_price

	var/icon_file = initial(item.icon)
	var/icon_state = initial(item.icon_state)
	var/icon/temp_icon = icon(icon_file, icon_state, SOUTH)
	icon_dimension = "[temp_icon.Width()]x[temp_icon.Height()]"
	qdel(temp_icon)
