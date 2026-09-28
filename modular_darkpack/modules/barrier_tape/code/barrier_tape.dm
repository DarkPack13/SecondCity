/obj/item/barrier_tape
	name = "barrier tape roll"
	icon = 'modular_darkpack/modules/barrier_tape/icons/barriertape.dmi'
	icon_state = "tape"
	abstract_type = /obj/item/barrier_tape
	w_class = WEIGHT_CLASS_SMALL
	custom_price = 15
	var/turf/start
	var/tape_type = /obj/structure/barrier_tape
	var/placing = FALSE
	var/datum/beam/tether

/obj/item/barrier_tape/update_overlays()
	. = ..()
	if(ismob(loc))
		. += mutable_appearance(icon, placing ? "stop" : "start", appearance_flags = RESET_COLOR|KEEP_APART)

/obj/item/barrier_tape/Destroy(force)
	. = ..()
	QDEL_NULL(tether)

/obj/item/barrier_tape/dropped(mob/user, silent)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/item/barrier_tape/pickup(mob/user)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/item/barrier_tape/attack_hand(mob/user, list/modifiers)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/item/barrier_tape/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/structure/vampdoor))
		var/turf/T = get_turf(interacting_with)
		var/obj/structure/barrier_tape/P = new tape_type(T)
		update_appearance(UPDATE_ICON)
		P.layer = ABOVE_ALL_MOB_LAYER + 0.1
		to_chat(user, span_notice("You finish placing [src]."))
		return ITEM_INTERACT_SUCCESS

/obj/item/barrier_tape/attack_self(mob/user, modifiers)
	. = ..()

	if(!placing)
		if(!do_after(user, 3 SECONDS, src))
			return FALSE

		start = get_turf(src)
		to_chat(user, span_notice("You place the first end of [src]."))
		placing = TRUE
		update_appearance(UPDATE_ICON)
		tether = start.Beam(user, "tape_v_0", 'modular_darkpack/modules/barrier_tape/icons/barriertape.dmi', beam_color = color, layer = BELOW_MOB_LAYER)
	else
		var/turf/end = get_turf(src)
		if(start.y != end.y && start.x != end.x || start.z != end.z)
			to_chat(user, span_notice("[src] can only be laid horizontally or vertically."))
			return

		var/turf/current_turf = start
		var/dir = 0
		if(start.x == end.x)
			var/d = end.y-start.y
			if(d)
				d = d/abs(d)
			end = get_turf(locate(end.x,end.y+d,end.z))
			dir = NORTH + SOUTH
		else
			var/d = end.x-start.x
			if(d)
				d = d/abs(d)
			end = get_turf(locate(end.x+d,end.y,end.z))
			dir = EAST + WEST

		var/can_place = TRUE
		while(current_turf != end && can_place)
			if(current_turf.density || istype(current_turf, /turf/open/space))
				can_place = FALSE
			else
				for(var/obj/O in current_turf)
					if(!istype(O, /obj/structure/barrier_tape) && O.density)
						can_place = FALSE
						break
			current_turf = get_step_towards(current_turf,end)

		if(!can_place)
			to_chat(user, span_notice("You can't run \the [src] through that!"))
			return

		if(!do_after(user, 3 SECONDS, src))
			return FALSE

		current_turf = start
		var/existing_tape = FALSE
		while(current_turf != end)
			for(var/obj/structure/barrier_tape/tape_on_turf in current_turf)
				if(tape_on_turf.tape_dir == dir)
					existing_tape = TRUE
			if(!existing_tape)
				var/obj/structure/barrier_tape/P = new tape_type(current_turf)
				P.tape_dir = dir
				P.update_appearance(UPDATE_ICON)
			current_turf = get_step_towards(current_turf, end)
		to_chat(user, span_notice("You finish placing [src]."))

		QDEL_NULL(tether)
		start = null
		placing = FALSE
		update_appearance(UPDATE_ICON)

		return TRUE


/obj/structure/barrier_tape
	name = "barrier tape"
	icon = 'modular_darkpack/modules/barrier_tape/icons/barriertape.dmi'
	icon_state = "tape"
	base_icon_state = "tape"
	abstract_type = /obj/structure/barrier_tape
	anchored = TRUE
	density = TRUE
	max_integrity = 10
	pass_flags_self = LETPASSTHROW
	projectile_cover = TRUE
	projectile_pass_rate = 90
	var/lifted = FALSE
	var/crumpled = FALSE
	var/tape_dir = 0
	var/detail_overlay
	var/detail_color

/obj/structure/barrier_tape/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Lift", lmb_text_combat_mode = "Tear")
	update_appearance()

/obj/structure/barrier_tape/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return .
	if(mover.pass_flags & PASSGLASS)
		return TRUE
	if(lifted)
		return TRUE
	return FALSE

/obj/structure/barrier_tape/update_icon_state()
	. = ..()
	//Possible directional bitflags: 0 (AIRLOCK), 1 (NORTH), 2 (SOUTH), 4 (EAST), 8 (WEST), 3 (VERTICAL), 12 (HORIZONTAL)
	var/new_state
	switch(tape_dir)
		if(0) // door
			new_state = "[base_icon_state]_door"
		if(3) // VERTICAL
			new_state = "[base_icon_state]_v"
		if(12) // HORIZONTAL
			new_state = "[base_icon_state]_h"
		else // END POINT (1|2|4|8)
			new_state = "[base_icon_state]_dir"
			dir = tape_dir
	icon_state = "[new_state]_[crumpled]"

/obj/structure/barrier_tape/update_overlays()
	. = ..()
	if(detail_overlay)
		var/new_state
		switch(tape_dir)
			if(0)
				new_state = "[base_icon_state]_door"
			if(3)
				new_state = "[base_icon_state]_v"
			if(12)
				new_state = "[base_icon_state]_h"
			else
				new_state = "[base_icon_state]_dir"
				dir = tape_dir
		var/image/detail = image(icon = src.icon, icon_state = "[new_state]_[detail_overlay]")
		detail.appearance_flags = RESET_COLOR
		detail.color = detail_color
		. += detail


/obj/structure/barrier_tape/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(user.combat_mode)
		user.visible_message(span_notice("[user] tears down [src]!"))
		playsound(src, 'sound/items/poster/poster_ripped.ogg', 100, TRUE)
		atom_destruction(MELEE)
	else
		if(lifted)
			return
		user.visible_message(span_notice("[user] lifts [src], allowing passage."))
		for(var/obj/structure/barrier_tape/connected_tape in get_connected_tape())
			connected_tape.lift_tape()

/obj/structure/barrier_tape/atom_deconstruct(disassembled)
	. = ..()
	var/obj/effect/decal/cleanable/plastic/trash = new(drop_location())
	transfer_fingerprints_to(trash)

/obj/structure/barrier_tape/proc/lift_tape()
	lifted = TRUE
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	addtimer(CALLBACK(src, PROC_REF(drop_tape)), 2 SECONDS)

/obj/structure/barrier_tape/proc/drop_tape()
	lifted = FALSE
	density = TRUE
	layer = initial(layer)

/obj/structure/barrier_tape/proc/crumple()
	if(!crumpled)
		crumpled = TRUE
		update_appearance(UPDATE_ICON)
		name = "crumpled [name]"

// Returns a list of all tape objects connected to src, including itself.
/obj/structure/barrier_tape/proc/get_connected_tape()
	var/list/dirs = list()
	if(tape_dir & NORTH)
		dirs += NORTH
	if(tape_dir & SOUTH)
		dirs += SOUTH
	if(tape_dir & WEST)
		dirs += WEST
	if(tape_dir & EAST)
		dirs += EAST

	var/list/obj/structure/barrier_tape/tapeline = list()
	for (var/obj/structure/barrier_tape/T in get_turf(src))
		tapeline += T
	for(var/dir in dirs)
		var/turf/current_turf = get_step(src, dir)
		var/not_found = 0
		while (!not_found)
			not_found = 1
			for (var/obj/structure/barrier_tape/T in current_turf)
				tapeline += T
				not_found = 0
			current_turf = get_step(current_turf, dir)
	return tapeline
