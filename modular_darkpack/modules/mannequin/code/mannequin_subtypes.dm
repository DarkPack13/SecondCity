/obj/structure/mannequin/plastic/napoleon
	starting_items = list(
		/obj/item/clothing/head/vampire/napoleon,
		/obj/item/clothing/under/vampire/napoleon,
		/obj/item/clothing/shoes/vampire/jackboots/high
	)

/obj/structure/mannequin/plastic/conquistador
	starting_items = list(
		/obj/item/clothing/head/vampire/helmet/spain,
		/obj/item/clothing/shoes/vampire/jackboots/work,
		/obj/item/clothing/under/vampire/tremere,
		/obj/item/clothing/suit/vampire/vest/medieval
	)

/obj/structure/mannequin/plastic/cowboy
	starting_items = list(
		/obj/item/clothing/head/vampire/cowboy,
		/obj/item/clothing/shoes/vampire/brown,
		/obj/item/clothing/under/vampire/bouncer,
		/obj/item/clothing/suit/vampire/trench/alt
	)

/obj/structure/mannequin/plastic/fancy/Initialize(mapload)
	if(prob(75))
		starting_items += pick(list(
			/obj/item/clothing/under/vampire/ventrue,
			/obj/item/clothing/under/vampire/ventrue/female,
			/obj/item/clothing/under/vampire/fancy_gray,
			/obj/item/clothing/under/vampire/fancy_red,
			/obj/item/clothing/under/vampire/leatherpants,
		))
	. = ..()

/obj/structure/mannequin/plastic/punk/Initialize(mapload)
	if(prob(75))
		starting_items += pick(list(
			/obj/item/clothing/under/vampire/punk,
			/obj/item/clothing/under/vampire/black,
			/obj/item/clothing/under/vampire/red,
			/obj/item/clothing/under/vampire/gothic,
			/obj/item/clothing/under/vampire/brujah,
			/obj/item/clothing/under/vampire/brujah/female,
			/obj/item/clothing/under/vampire/gangrel,
			/obj/item/clothing/under/vampire/gangrel/female,
		))
	. = ..()
