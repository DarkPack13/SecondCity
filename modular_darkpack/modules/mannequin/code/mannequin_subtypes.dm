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

/obj/structure/mannequin/plastic/soviet
	starting_items = list(
		/obj/item/clothing/head/helmet/rus_ushanka,
		/obj/item/clothing/shoes/vampire/jackboots/high,
		/obj/item/clothing/under/costume/soviet,
		/obj/item/clothing/suit/costume/soviet
	)

/obj/structure/mannequin/plastic/nemes
	starting_items = list(
		/obj/item/clothing/head/costume/nemes,
		/obj/item/clothing/shoes/sandal,
		/obj/item/clothing/under/costume/loincloth,
		/obj/item/clothing/suit/costume/nemes
	)

/obj/structure/mannequin/plastic/roman
	starting_items = list(
		/obj/item/clothing/head/helmet/roman,
		/obj/item/clothing/shoes/roman,
		/obj/item/clothing/under/costume/roman,
		/obj/item/shield/roman/fake
	)

/obj/structure/mannequin/plastic/medieval
	starting_items = list(
		/obj/item/clothing/head/helmet/military,
		/obj/item/clothing/shoes/vampire/jackboots/work,
		/obj/item/clothing/under/costume/gamberson/military,
		/obj/item/clothing/suit/armor/vest/military
	)

/obj/structure/mannequin/plastic/dutch
	starting_items = list(
		/obj/item/clothing/head/vampire/cowboy,
		/obj/item/clothing/shoes/cowboy/black,
		/obj/item/clothing/under/costume/dutch,
		/obj/item/clothing/suit/vampire/trench
	)
