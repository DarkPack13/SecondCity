/obj/item/vampire_flamethrower
	name = "flamethrower"
	desc = "Well fire weapon."
	icon_state = "flamethrower4"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	masquerade_violating = TRUE
	var/oil = 1000

/obj/item/vampire_flamethrower/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/gas_can))
		var/obj/item/gas_can/G = W
		if(G.stored_gasoline > 10 && oil < 1000)
			var/gas_to_transfer = min(G.stored_gasoline, 1000-oil)
			G.stored_gasoline = max(0, G.stored_gasoline-gas_to_transfer)
			oil = min(1000, oil+gas_to_transfer)
			if(oil)
				playsound(get_turf(user), 'modular_darkpack/master_files/sounds/effects/gas_fill.ogg', 50, TRUE)
				to_chat(user, span_notice("You fill [src]."))
				icon_state = "flamethrower4"

/obj/item/vampire_flamethrower/examine(mob/user)
	. = ..()
	. += "<b>Ammo:</b> [(oil/1000)*100]%"

/obj/item/vampire_flamethrower/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
//	if(flag)
//		return
//	if(ishuman(user))
//		if(!can_trigger_gun(user))
//			return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You can't bring yourself to fire \the [src]! You don't want to risk harming anyone..."))
		return
	playsound(get_turf(user), 'modular_darkpack/modules/deprecated/sounds/flamethrower.ogg', 50, TRUE)
	visible_message(span_warning("[user] fires [src]!"), span_warning("You fire [src]!"))
	if(user && user.get_active_held_item() == src) // Make sure our user is still holding us
		var/turf/target_turf = get_turf(target)
		if(target_turf)
			var/turflist = getline(user, target_turf)
			log_combat(user, target, "flamethrowered", src)
			for(var/turf/open/floor/F in turflist)
				if(F != user.loc)
					if(oil)
						new /obj/effect/decal/cleanable/gasoline(F)
						oil = max(0, oil-10)
						if(oil == 0)
							icon_state = "flamethrower1"
					new /obj/effect/fire(F)
