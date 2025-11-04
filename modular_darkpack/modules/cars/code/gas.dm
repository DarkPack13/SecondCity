/* TODO: [Rebase] - Gas should be handled as a reagent
/datum/reagent/gasoline
	name = "Gasoline"
	color = "#b85614"

/obj/item/reagent_containers/cup/gas_can
	name = "gas can"
	desc = "Stores gasoline or pure fire death."
	icon_state = "gasoline"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/gasoline = 200)
*/

/obj/item/gas_can
	name = "gas can"
	desc = "Stores gasoline or pure fire death."
	icon_state = "gasoline"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	var/stored_gasoline = 0

/obj/item/gas_can/examine(mob/user)
	. = ..()
	. += "<b>Gas</b>: [stored_gasoline]/1000"

/obj/item/gas_can/full
	stored_gasoline = 1000

/obj/item/gas_can/rand

/obj/item/gas_can/rand/Initialize(mapload)
	. = ..()
	stored_gasoline = rand(0, 500)

/obj/item/gas_can/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/darkpack_car) || istype(interacting_with, /obj/structure/fuelstation) || istype(interacting_with, /mob/living/carbon/human))
		return NONE
	if(istype(get_turf(interacting_with), /turf/open/floor))
		if(locate(/obj/effect/decal/cleanable/gasoline) in get_turf(interacting_with))
			return ITEM_INTERACT_FAILURE
		if(stored_gasoline < 50)
			return ITEM_INTERACT_FAILURE
		stored_gasoline = max(0, stored_gasoline-50)
		new /obj/effect/decal/cleanable/gasoline(get_turf(interacting_with))
		playsound(get_turf(src), 'modular_darkpack/modules/cars/sounds/gas_splat.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS

/obj/item/gas_can/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		if(stored_gasoline < 50)
			return
		stored_gasoline = max(0, stored_gasoline-50)
		H.fire_stacks = min(10, H.fire_stacks+10)
		playsound(get_turf(H), 'modular_darkpack/modules/cars/sounds/gas_splat.ogg', 50, TRUE)
		user.visible_message(span_warning("[user] covers [target] in something flammable!"))

/obj/effect/decal/cleanable/gasoline
	name = "gasoline"
	desc = "I HOPE YOU DIE IN A FIRE!!!"
	icon = 'modular_darkpack/modules/cars/icons/water.dmi'
	icon_state = "water"
	base_icon_state = "water"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_SPILL
	canSmoothWith = SMOOTH_GROUP_SPILL + SMOOTH_GROUP_WALLS
	//mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	beauty = -50
	alpha = 64
	color = "#c6845b"

/obj/effect/decal/cleanable/gasoline/update_icon(updates=ALL)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & USES_SMOOTHING))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)

/*
/obj/effect/decal/cleanable/gasoline/Crossed(atom/movable/AM, oldloc)
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.on_fire)
			var/obj/effect/fire/F = locate() in get_turf(src)
			if(!F)
				new /obj/effect/fire(get_turf(src))
	..(AM)
*/

/obj/effect/decal/cleanable/gasoline/Initialize()
	. = ..()
	/*
	var/turf/T = get_turf(src)
	if(istype(T, /turf/open/floor))
		var/turf/open/floor/F = T
		F.spread_chance = 100
		F.burn_material += 100
	*/
	if(smoothing_flags & USES_SMOOTHING)
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)

/obj/effect/decal/cleanable/gasoline/Destroy()
	QUEUE_SMOOTH_NEIGHBORS(src)
	return ..()

/*
/obj/effect/decal/cleanable/gasoline/fire_act(exposed_temperature, exposed_volume)
	var/obj/effect/fire/F = locate() in loc
	if(!F)
		new /obj/effect/fire(loc)
	..()
*/

/obj/effect/decal/cleanable/gasoline/attackby(obj/item/I, mob/living/user)
	var/attacked_by_hot_thing = I.get_temperature()
	if(attacked_by_hot_thing)
		visible_message("<span class='warning'>[user] tries to ignite [src] with [I]!</span>", "<span class='warning'>You try to ignite [src] with [I].</span>")
		log_combat(user, src, (attacked_by_hot_thing < 480) ? "tried to ignite" : "ignited", I)
		fire_act(attacked_by_hot_thing)
		return
	return ..()

/obj/structure/fuelstation
	name = "fuel station"
	desc = "Fuel your car here. 50 dollars per 1000 units."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "fuelstation"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/stored_money = 0

/obj/structure/fuelstation/click_alt(mob/user)
	if(stored_money > 0)
		say("Money refunded.")
		var/money_to_spawn = min(stored_money, 1000)
		new /obj/item/stack/dollar(loc, money_to_spawn)
		stored_money -= money_to_spawn
		return CLICK_ACTION_SUCCESS

/obj/structure/fuelstation/examine(mob/user)
	. = ..()
	. += "<b>Balance</b>: [stored_money] dollars"

/obj/structure/fuelstation/attackby(obj/item/I, mob/living/user, params)
	if(iscash(I))
		stored_money += I.get_item_credit_value()
		to_chat(user, span_notice("You insert [I.get_item_credit_value()] dollars into [src]."))
		qdel(I)
		say("Payment received.")
	if(istype(I, /obj/item/gas_can))
		var/obj/item/gas_can/G = I
		if(G.stored_gasoline < 1000 && stored_money)
			var/gas_to_dispense = min(stored_money*20, 1000-G.stored_gasoline)
			var/money_to_spend = round(gas_to_dispense/20)
			G.stored_gasoline = min(1000, G.stored_gasoline+gas_to_dispense)
			stored_money = max(0, stored_money-money_to_spend)
			playsound(loc, 'modular_darkpack/master_files/sounds/effects/gas_fill.ogg', 50, TRUE)
			to_chat(user, span_notice("You fill [I]."))
			say("Gas filled.")
