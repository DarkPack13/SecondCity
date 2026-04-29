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
	var/complex = FALSE

	/// Stores the most recent target of the ability that succeeded
	var/datum/weakref/last_target_ref
	/// When the currently weakrefed target was first used.
	var/first_target_use = 0

/datum/action/cooldown/power/gift/control_machine/set_click_ability(mob/on_who)
	. = ..()
	// SEND_SOUND(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/falling_touch.ogg')

/datum/action/cooldown/power/gift/control_machine/Activate(atom/target)
	. = ..()
	var/choices = target.get_control_machine_options(owner, complex)
	if(!length(choices))
		return FALSE

	var/choice = show_radial_menu(owner, target, choices, autopick_single_option = FALSE)
	if(!choice)
		return

	if(!roll_datum)
		roll_datum = new roll_type()

	if(first_target_use + 1 SCENES < world.time) // Its been active for a whole scene. Clear it
		last_target_ref = null

	var/free_to_use = FALSE

	var/last_target = last_target_ref?.resolve()
	if(last_target == target)
		free_to_use = TRUE

	if(free_to_use)
		target.run_control_machine(owner, choice, complex)
	else if(roll_datum.st_roll(owner, target) == ROLL_SUCCESS)
		target.run_control_machine(owner, choice, complex)
		last_target_ref = WEAKREF(target)
		first_target_use = world.time

	if(!free_to_use)
		spend_resources()

	StartCooldown()
	return TRUE


/datum/action/cooldown/power/gift/control_machine/simple
	name = "Control Simple Machine"
	desc = "The Garou may command the spirits of the simplest machines, causing levers to flip, doors to unbolt, pulleys to roll, and so on."

	rank = 1

	roll_type = /datum/storyteller_roll/gift/control_simple_machine

/datum/action/cooldown/power/gift/control_machine/complex
	name = "Control Complex Machine"
	desc = "Similar to Control Simple Machine, the Glass Walker may now converse with and command the spirits of electronic devices such as computers, smart phones, and cars."

	rank = 3

	roll_type = /datum/storyteller_roll/gift/control_complex_machine
	complex = TRUE

/atom/proc/get_control_machine_options(mob/living/user, complex = FALSE)
	RETURN_TYPE(/list)

	. = list()

/atom/proc/run_control_machine(mob/living/user, choice, complex = FALSE)
	return


/obj/machinery/get_control_machine_options(mob/living/user, complex = FALSE)
	. = ..()
	.["unscrew"] = image(icon = 'icons/hud/radial.dmi', icon_state = "machine")

/obj/machinery/run_control_machine(mob/living/user, choice, complex = FALSE)
	. = ..()
	if(complex)
		return
	switch(choice)
		if("unscrew")
			toggle_panel_open()
			balloon_alert(user, "maintenance hatch [panel_open ? "opened" : "closed"]")


/obj/machinery/button/get_control_machine_options(mob/living/user, complex = FALSE)
	. = ..()
	.["flick"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/machinery/button/run_control_machine(mob/living/user, choice, complex = FALSE)
	. = ..()
	if(complex)
		return
	switch(choice)
		if("flick")
			attempt_press(user)


/obj/machinery/shower/get_control_machine_options(mob/living/user, complex = FALSE)
	. = ..()
	if(!complex)
		.["turn"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

/obj/machinery/shower/run_control_machine(mob/living/user, choice, complex = FALSE)
	. = ..()
	if(complex)
		return
	switch(choice)
		if("turn")
			interact(user)


/obj/vehicle/ridden/scooter/get_control_machine_options(mob/living/user, complex = FALSE)
	. = ..()
	if(!complex)
		.["roll"] = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_rotate")

/obj/vehicle/ridden/scooter/run_control_machine(mob/living/user, choice, complex = FALSE)
	. = ..()
	if(complex)
		return
	switch(choice)
		if("roll")
			step(src, dir)
