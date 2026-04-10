///DARKPACK - Money bag subtype; covers Darkpack money types
/obj/item/storage/bag/money
	storage_type = /datum/storage/bag/money/darkpack

//Prespawned variants for the bank
/obj/item/storage/bag/money/bank_cash/PopulateContents()	//4+ grand per bag
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/rand (src)
	new /obj/item/stack/dollar/rand (src)
	new /obj/item/stack/dollar/rand (src)
	new /obj/item/stack/dollar/rand (src)
	new /obj/item/stack/dollar/rand (src)

/obj/item/storage/bag/money/bank_cash_high/PopulateContents()	//10 grand per bag
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)
	new /obj/item/stack/dollar/thousand (src)

/obj/item/storage/bag/money/bank_gold/PopulateContents()
	new /obj/item/stack/sheet/mineral/gold/fifty(src)

/obj/item/storage/bag/money/bank_silver/PopulateContents()
	new /obj/item/stack/sheet/mineral/silver/fifty(src)
