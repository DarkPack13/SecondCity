/obj/item/stack/dollar
	name = "dollars"
	desc = "Wow! With enough of these, you could buy a lot! ...Pssh, yeah right."
	singular_name = "dollar"
	icon_state = "money1"
	icon = 'icons/wod13/items.dmi'
	lefthand_file = null
	righthand_file = null
	onflooricon = 'icons/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_TINY
	max_amount = 1000
	merge_type = /obj/item/stack/dollar

/obj/item/stack/dollar/five
	amount = 5

/obj/item/stack/dollar/ten
	amount = 10

/obj/item/stack/dollar/fifty
	amount = 50

/obj/item/stack/dollar/hundred
	amount = 100

/obj/item/stack/dollar/rand
	amount = 1.3

/obj/item/stack/dollar/rand/Initialize(mapload, new_amount, merge = TRUE, list/mat_override = null, mat_amt = 1)
	. = ..()

	amount = rand(5, 30)
	update_icon()
