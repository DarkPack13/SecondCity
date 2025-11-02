/obj/item/bong
	name = "bong"
	desc = "Technically known as a water pipe."
	icon = 'modular_darkpack/modules/drugs/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/drugs/icons/onfloor.dmi')
	icon_state = "bulbulator"

	light_range = 1
	light_color = LIGHT_COLOR_FIRE
	light_system = OVERLAY_LIGHT
	light_on = FALSE

	///The icon state when the bong is lit
	var/icon_on = "bulbulator"
	///The icon state when the bong is not lit
	var/icon_off = "bulbulator"
	///Whether the bong is lit or not
	var/lit = FALSE
	///How many hits can the bong be used for?
	var/max_hits = 4
	///How many uses does the bong have remaining?
	var/bong_hits = 0
	///How likely is it we moan instead of cough?
	var/moan_chance = 0

	///Max units able to be stored inside the bong
	var/chem_volume = 100
	///Is it filled?
	var/packeditem = FALSE

	///How many reagents do we transfer each use?
	var/reagent_transfer_per_use = 0
	///How far does the smoke reach per use?
	var/smoke_range = 2

/obj/item/bong/Initialize(mapload)
	. = ..()
	create_reagents(chem_volume, INJECTABLE | NO_REACT)

/obj/item/bong/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if((istype(attacking_item, /obj/item/food/grown) || istype(attacking_item, /obj/item/food/drug)))
		if(packeditem)
			to_chat(user, span_warning("It is already packed!"))
			return

		if(istype(attacking_item, /obj/item/food/grown) && !HAS_TRAIT(attacking_item, TRAIT_DRIED))
			to_chat(user, span_warning("It has to be dried first!"))
			return

		to_chat(user, span_notice("You stuff [attacking_item] into [src]."))
		bong_hits = max_hits
		packeditem = attacking_item.name
		update_name()
		if(attacking_item.reagents)
			attacking_item.reagents.trans_to(src, attacking_item.reagents.total_volume, transferred_by = user)
			reagent_transfer_per_use = reagents.total_volume / max_hits
		qdel(attacking_item)
	else
		var/lighting_text = attacking_item.ignition_effect(src, user)
		if(!lighting_text)
			return ..()
		if(bong_hits <= 0)
			to_chat(user, span_warning("Nothing to smoke!"))
			return ..()
		light(lighting_text)

/obj/item/bong/attack_self(mob/user)
	var/turf/location = get_turf(user)
	if(lit)
		user.visible_message(span_notice("[user] puts out [src]."), span_notice("You put out [src]."))
		put_out()
	else if(!lit && bong_hits > 0)
		to_chat(user, span_notice("You empty [src] onto [location]."))
		new /obj/effect/decal/cleanable/ash(location)
		empty_out()
	return

/obj/item/bong/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!packeditem || !lit)
		return
	target_mob.visible_message(
		span_notice("[user] starts [target_mob == user ? "taking a hit from [src]." : "forcing [target_mob] to take a hit from [src]!"]"),
		"[target_mob == user ? span_notice("You start taking a hit from [src].") : span_danger("[user] starts forcing you to take a hit from [src]!")]"
	)
	playsound(src, 'modular_darkpack/modules/drugs/sounds/heatdam.ogg', 50, TRUE)
	if(!do_after(user, 4 SECONDS, src))
		return
	to_chat(target_mob, span_notice("You finish taking a hit from [src]."))
	if(reagents.total_volume)
		reagents.trans_to(target_mob, reagent_transfer_per_use, methods = INHALE, ignore_stomach = TRUE)
		bong_hits--
	var/turf/open/pos = get_turf(src)
	if(istype(pos))
		for(var/i in 1 to smoke_range)
			spawn_cloud(pos, smoke_range)
	if(moan_chance > 0)
		if(prob(moan_chance))
			playsound(target_mob, pick('modular_darkpack/modules/drugs/sounds/lungbust_moan1.ogg','modular_darkpack/modules/drugs/sounds/lungbust_moan2.ogg', 'modular_darkpack/modules/drugs/sounds/lungbust_moan3.ogg'), 50, TRUE)
			target_mob.emote("moan")
		else
			playsound(target_mob, pick('modular_darkpack/modules/drugs/sounds/lungbust_cough1.ogg','modular_darkpack/modules/drugs/sounds/lungbust_cough2.ogg'), 50, TRUE)
			target_mob.emote("cough")
	if(bong_hits <= 0)
		to_chat(target_mob, span_warning("Out of uses!"))
		put_out()
		empty_out()

/obj/item/bong/proc/light(flavor_text = null)
	if(lit)
		return
	if(!(flags_1 & INITIALIZED_1))
		icon_state = icon_on
		return
	lit = TRUE
	name = "lit [initial(name)]"
	set_light_on(TRUE)

	if(reagents.get_reagent_amount(/datum/reagent/toxin/plasma)) // the plasma explodes when exposed to fire
		var/datum/effect_system/reagents_explosion/explosion = new()
		explosion.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/plasma) * 0.4, 1), get_turf(src), 0, 0)
		explosion.start()
		qdel(src)
		return
	if(reagents.get_reagent_amount(/datum/reagent/fuel)) // the fuel explodes, too, but much less violently
		var/datum/effect_system/reagents_explosion/explosion = new()
		explosion.set_up(round(reagents.get_reagent_amount(/datum/reagent/fuel) * 0.2, 1), get_turf(src), 0, 0)
		explosion.start()
		qdel(src)
		return

	// allowing reagents to react after being lit
	reagents.flags &= ~(NO_REACT)
	reagents.handle_reactions()
	icon_state = icon_on
	if(flavor_text)
		visible_message(flavor_text)

/obj/item/bong/proc/put_out()
	set_light_on(FALSE)
	lit = FALSE
	name = "[initial(name)]"
	icon_state = icon_off

/obj/item/bong/proc/empty_out()
	packeditem = FALSE
	bong_hits = 0
	reagents.clear_reagents() //just to make sure

/obj/item/bong/proc/spawn_cloud(turf/open/location, smoke_range)
	var/list/turfs_affected = list(location)
	var/list/turfs_to_spread = list(location)
	var/spread_stage = smoke_range
	for(var/i in 1 to smoke_range)
		if(!turfs_to_spread.len)
			break
		var/list/new_spread_list = list()
		for(var/turf/open/turf_to_spread as anything in turfs_to_spread)
			if(isspaceturf(turf_to_spread))
				continue
			var/obj/effect/abstract/fake_steam/fake_steam = locate() in turf_to_spread
			var/at_edge = FALSE
			if(!fake_steam)
				at_edge = TRUE
				fake_steam = new(turf_to_spread)
			fake_steam.stage_up(spread_stage)

			if(!at_edge)
				for(var/turf/open/open_turf as anything in turf_to_spread.atmos_adjacent_turfs)
					if(!(open_turf in turfs_affected))
						new_spread_list += open_turf
						turfs_affected += open_turf

		turfs_to_spread = new_spread_list
		spread_stage--
