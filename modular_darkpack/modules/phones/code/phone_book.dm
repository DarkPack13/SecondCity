/obj/item/phone_book
	name = "phone book"
	desc = "See the actual numbers in the city."
	icon_state = "phonebook"
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/phones/icons/phone_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/phone_book/attack_self(mob/user)
	. = ..()
	for(var/i as anything in SSphones.assigned_phone_numbers)
		to_chat(user, "[SSphones.assigned_phone_numbers[i]]")
