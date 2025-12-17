/datum/discipline/path
	var/action_type = /datum/action/discipline/path
	var/action_replaced = FALSE
	selectable = FALSE //cant buy it as a ghoul

// Override post_gain to replace the action after the base system is done
/datum/discipline/path/post_gain()
	. = ..()

	if(action_replaced || !owner)
		return

	addtimer(CALLBACK(src, PROC_REF(replace_base_action)), 1 SECONDS)

// so a 'base action' was being created for the paths, bugging out the UI, solved this by just replacing this 'base action' upon creation
/datum/discipline/path/proc/replace_base_action()
	if(!owner)
		return

	var/datum/action/discipline/base_action = null
	for(var/datum/action/discipline/action in owner.actions)
		if(action.discipline == src && action.type == /datum/action/discipline)
			base_action = action
			break

	if(base_action)
		var/datum/action/discipline/path/path_action = new /datum/action/discipline/path(src)
		base_action.Remove(owner)
		qdel(base_action)
		path_action.Grant(owner)
		action_replaced = TRUE

/datum/action/discipline/path
	check_flags = NONE
	background_icon = 'modular_darkpack/modules/paths/icons/paths.dmi'
	button_icon = 'modular_darkpack/modules/paths/icons/paths.dmi'
	background_icon_state = "default"
	button_icon_state = "default"

/datum/action/discipline/path/New(datum/discipline/discipline)
	. = ..()

/datum/action/discipline/path/apply_button_overlay(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	. = ..()

	current_button.cut_overlays(TRUE)

	if(discipline)
		var/discipline_icon_state = discipline.icon_state || "default"
		current_button.add_overlay(mutable_appearance('modular_darkpack/modules/paths/icons/paths.dmi', discipline_icon_state))

		if(discipline.level_casting)
			current_button.add_overlay(mutable_appearance('modular_darkpack/modules/paths/icons/paths.dmi', "[discipline.level_casting]"))
	else
		current_button.add_overlay(mutable_appearance('modular_darkpack/modules/paths/icons/paths.dmi', "default"))

/datum/action/discipline/path/update_button_name(atom/movable/screen/movable/action_button/button, force = FALSE)
	if(discipline?.current_power)
		button.name = discipline.current_power.name
		button.desc = discipline.current_power.desc
	else
		return ..()

