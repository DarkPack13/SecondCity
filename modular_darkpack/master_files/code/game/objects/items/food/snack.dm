/obj/item/food/chips
	name = "\improper \"Days\" chips"
	desc = "\"Days\" chips... Crispy!"
	icon_state = "crisps2"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	custom_price = 2
	food_flags = FOOD_IN_CONTAINER | FOOD_BITE_SPRITE
	preserved_food = TRUE

/obj/item/food/chips/proc/open_crisps(mob/user)
	to_chat(user, span_notice("You pull back the wrapper of \the [src]."))
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	icon_state = "crisps1"
	reagents.flags |= OPENCONTAINER
	preserved_food = FALSE

/obj/item/food/chips/attack_self(mob/user, modifiers)
	if(!is_drainable())
		open_crisps(user)
	return ..()

/obj/item/food/chips/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!is_drainable())
		to_chat(user, span_warning("[src]'s wrapper hasn't been opened!"))
		return FALSE
	return ..()

/obj/item/food/chips/shrimp
	icon_state = "crisps2"

/obj/item/food/chocolatebar
	icon_state = "bar2"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 1
	trash_type = /obj/item/trash/vampirebar
	tastes = list("chocolate" = 1)
	food_flags = FOOD_FINGER_FOOD|FOOD_BITE_SPRITE
	preserved_food = TRUE

/obj/item/food/chocolatebar/proc/open_bar(mob/user)
	to_chat(user, span_notice("You pull back the wrapper of \the [src]."))
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	icon_state = "bar1"
	reagents.flags |= OPENCONTAINER
	preserved_food = FALSE

/obj/item/food/chocolatebar/attack_self(mob/user)
	if(!is_drainable())
		open_bar(user)
	return ..()

/obj/item/food/chocolatebar/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, span_warning("[src]'s wrapper hasn't been opened!"))
		return FALSE
	return ..()
