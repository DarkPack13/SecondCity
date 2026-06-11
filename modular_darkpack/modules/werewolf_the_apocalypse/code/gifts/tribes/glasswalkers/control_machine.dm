/datum/storyteller_roll/gift/control_simple_machine
	bumper_text = "Control Simple Machine"
	applicable_stats = list(STAT_MANIPULATION, STAT_CRAFTS)
	difficulty = 7

/datum/storyteller_roll/gift/control_complex_machine
	bumper_text = "Control Complex Machine"
	applicable_stats = list(STAT_MANIPULATION, STAT_SCIENCE) // or STAT_COMPUTER


/datum/action/cooldown/power/gift/control_machine
	abstract_type = /datum/action/cooldown/power/gift/control_machine

	click_to_activate = TRUE

	handles_spend_resources = TRUE
	willpower_cost = 1

	var/roll_type
	var/datum/storyteller_roll/roll_datum
	var/is_complex = FALSE

	/// Stores the most recent target of the ability that succeeded
	var/datum/weakref/last_target_ref
	/// When the currently weakrefed target was first used.
	var/first_target_use = 0

	var/list/image/object_highlights

/datum/action/cooldown/power/gift/control_machine/set_click_ability(mob/on_who)
	. = ..()
	if(!on_who.client)
		return

	var/existing_target = last_target_ref?.resolve()

	// Movable cause i dont feel like checking EVERY EVERY atom.
	for(var/atom/movable/nearby_atom in oview(on_who, DEFAULT_SIGHT_DISTANCE))
		if(!length(nearby_atom.get_control_machine_options(on_who, is_complex)))
			continue
		var/color = COLOR_BLUE_LIGHT
		if(nearby_atom == existing_target)
			color = COLOR_BLUE

		var/image/I = image(loc = nearby_atom)
		I.appearance = nearby_atom.appearance
		I.layer = nearby_atom.layer - 0.01
		I.pixel_y = 0
		I.pixel_x = 0
		I.pixel_w = 0
		I.pixel_z = 0

		apply_wibbly_filters(I)

		I.add_filter("control_machine", 1, outline_filter(size = 1, color = color))

		LAZYINITLIST(object_highlights)
		on_who.client.images += I
		object_highlights += I

	// Could probaly use a sound.

/datum/action/cooldown/power/gift/control_machine/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!on_who.client || !object_highlights)
		return
	for(var/image/I in object_highlights)
		if(I in on_who.client.images)
			on_who.client.images -= I
	QDEL_LAZYLIST(object_highlights)

// could use sounds
/datum/action/cooldown/power/gift/control_machine/Activate(atom/target)
	var/choices = target.get_control_machine_options(owner, is_complex)
	if(!length(choices))
		return FALSE

	var/choice = show_radial_menu(owner, target, choices, autopick_single_option = FALSE)
	if(!choice)
		return

	. = ..()

	if(!roll_datum)
		roll_datum = new roll_type()

	if(first_target_use + 1 SCENES < world.time) // Its been active for a whole scene. Clear it
		last_target_ref = null
		willpower_cost = 1

	var/free_to_use = FALSE

	var/last_target = last_target_ref?.resolve()
	if(last_target == target)
		free_to_use = TRUE
		willpower_cost = 0

	if(free_to_use)
		target.run_control_machine(owner, choice, is_complex)
	else if(roll_datum.st_roll(owner, target) == ROLL_SUCCESS)
		target.run_control_machine(owner, choice, is_complex)
		last_target_ref = WEAKREF(target)
		first_target_use = world.time

	spend_resources()

	return TRUE


/datum/action/cooldown/power/gift/control_machine/simple
	name = "Control Simple Machine"
	desc = "The Garou may command the spirits of the simplest machines, causing levers to flip, doors to unbolt, pulleys to roll, and so on."
	button_icon_state = "control_simple_machine"

	rank = 1

	roll_type = /datum/storyteller_roll/gift/control_simple_machine

// DARKPACK TODO - (gifts past rank 1)
/datum/action/cooldown/power/gift/control_machine/complex
	name = "Control Complex Machine"
	desc = "Similar to Control Simple Machine, the Glass Walker may now converse with and command the spirits of electronic devices such as computers, smart phones, and cars."

	rank = 3

	roll_type = /datum/storyteller_roll/gift/control_complex_machine
	is_complex = TRUE


/atom/proc/get_control_machine_options(mob/living/user, is_complex = FALSE)
	RETURN_TYPE(/list)

	. = list()

/atom/proc/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	return


/obj/item/grenade/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	.["prime"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/item/grenade/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("prime")
			arm_grenade()


/obj/item/lighter/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	.["light"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/item/lighter/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("light")
			set_lit(!lit)


/* Breaks due to requirng a user really hard.
/obj/item/gun/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	.["fire"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/item/gun/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("fire")
			process_fire(get_turf(src))
*/


/*
/obj/machinery/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	.["unscrew"] = image(icon = 'icons/hud/radial.dmi', icon_state = "machine")

/obj/machinery/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("unscrew")
			toggle_panel_open()
			balloon_alert(user, "maintenance hatch [panel_open ? "opened" : "closed"]")
*/

/obj/machinery/light/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	if(status != LIGHT_EMPTY)
		.["unscrew"] = image(icon = 'icons/hud/radial.dmi', icon_state = "machine")

/obj/machinery/light/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("unscrew")
			var/obj/item/light/bulb = drop_light_tube()
			bulb?.shatter()


/obj/machinery/button/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	.["flick"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/machinery/button/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("flick")
			attempt_press(user)


/obj/machinery/shower/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	if(!is_complex)
		.["turn"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/machinery/shower/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("turn")
			interact(user)


/obj/machinery/firealarm/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	if(!is_complex)
		.["flip"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/machinery/firealarm/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("flip")
			alarm(user)


/obj/vehicle/ridden/scooter/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	if(!is_complex)
		.["roll"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_rotate")

/obj/vehicle/ridden/scooter/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("roll")
			step(src, dir)


/obj/structure/vampdoor/get_control_machine_options(mob/living/user, is_complex = FALSE)
	. = ..()
	if(!is_complex)
		.["lock"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_rotate")

/obj/structure/vampdoor/run_control_machine(mob/living/user, choice, is_complex = FALSE)
	. = ..()
	if(is_complex)
		return
	switch(choice)
		if("lock")
			if(!locked)
				toggle_lock(user)
