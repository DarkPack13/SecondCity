// TODO: [Rebase] - Gas should be handled as a reagent
/obj/item/liquid_flamethrower
	name = "flamethrower"
	desc = "Well fire weapon."
	icon_state = "flamethrower4"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 3
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	resistance_flags = FIRE_PROOF
	trigger_guard = TRIGGER_GUARD_NORMAL
	light_system = OVERLAY_LIGHT
	light_color = LIGHT_COLOR_FLARE
	light_range = 2
	light_power = 2
	light_on = FALSE
	interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING
	var/oil = 1000
	var/operating = FALSE

/obj/item/liquid_flamethrower/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/liquid_flamethrower/attackby(obj/item/W, mob/user, params)
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

/obj/item/liquid_flamethrower/examine(mob/user)
	. = ..()
	. += "<b>Ammo:</b> [(oil/1000)*100]%"

/obj/item/liquid_flamethrower/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You can't bring yourself to fire \the [src]! You don't want to risk harming anyone..."))
		return ITEM_INTERACT_BLOCKING
	playsound(get_turf(user), 'modular_darkpack/modules/deprecated/sounds/flamethrower.ogg', 50, TRUE)
	visible_message(span_warning("[user] fires [src]!"), span_warning("You fire [src]!"))
	var/turf/target_turf = get_turf(interacting_with)
	if(target_turf)
		var/turflist = get_line(user, target_turf)
		log_combat(user, interacting_with, "flamethrowered", src)
		flame_turf(turflist)

	return ITEM_INTERACT_SUCCESS

/obj/item/liquid_flamethrower/proc/flame_turf(turflist)
	if(operating)
		return
	operating = TRUE
	var/turf/previousturf = get_turf(src)
	for(var/turf/T in turflist)
		if(T == previousturf)
			continue //so we don't burn the tile we be standin on
		var/list/turfs_sharing_with_prev = previousturf.get_atmos_adjacent_turfs(alldir=1)
		if(!(T in turfs_sharing_with_prev))
			break
		if(oil < 10)
			icon_state = "flamethrower1"
			return
		oil = max(0, oil-10)
		new /obj/effect/decal/cleanable/gasoline(T)
		T.ignite_turf(30, "red")
		sleep(0.1 SECONDS)
		previousturf = T
	operating = FALSE
