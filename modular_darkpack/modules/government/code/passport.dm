/obj/item/passport
	name = "\improper fake passport"
	desc = "Just some book with words, none of real identity here."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon_state = "passport1"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID
	onflooricon = 'modular_darkpack/modules/deprecated/icons/onfloor.dmi'

	var/clozed = TRUE

/obj/item/passport/attack_self(mob/user)
	. = ..()
	if(clozed)
		clozed = FALSE
		icon_state = "passport0"
		to_chat(user, "<span class='notice'>You open [src].</span>")
	else
		clozed = TRUE
		icon_state = "passport1"
		to_chat(user, "<span class='notice'>You close [src].</span>")
