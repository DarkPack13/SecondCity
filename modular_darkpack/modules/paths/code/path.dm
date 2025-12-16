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
		// Create the path action
		var/datum/action/discipline/path/path_action = new /datum/action/discipline/path(src)

		// Remove the base action
		base_action.Remove(owner)
		qdel(base_action)

		// Grant the path action
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
	. = ..() // Call parent to handle signals

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

ADMIN_VERB(grant_discipline, R_ADMIN, "Grant Discipline", "Grant a Discipline to a player.", ADMIN_CATEGORY_GAME)
	var/mob/living/carbon/human/target = input(user, "Select a player to grant a Discipline to:", "Grant Discipline") as null|mob in GLOB.player_list
	if(!target || !ishuman(target))
		to_chat(user, span_warning("Invalid target selected."))
		return

	// Check if they're a vampire/ghoul (adjust this check based on your species system)
	if(!ishuman(target))
		to_chat(user, span_warning("Target must be a vampire or ghoul."))
		return

	var/list/available_disciplines = subtypesof(/datum/discipline) - /datum/discipline/bloodheal
	var/datum/discipline/chosen_discipline = input(user, "Select a Discipline:", "Grant Discipline") as null|anything in available_disciplines
	if(!chosen_discipline)
		return

	var/chosen_level = input(user, "Select Discipline level (1-6):", "Grant Discipline") as null|num
	if(isnull(chosen_level) || chosen_level < 1 || chosen_level > 6)
		return

	var/reason = input(user, "Reason for granting this Discipline:", "Grant Discipline") as null|text
	if(!reason)
		return

	// Create and grant the discipline
	var/datum/discipline/new_discipline = new chosen_discipline(chosen_level)

	// Grant it to the target
	target.give_discipline(new_discipline)

	// Logging
	message_admins("[ADMIN_LOOKUPFLW(user)] gave [ADMIN_LOOKUPFLW(target)] the Discipline [new_discipline.name] at rank [chosen_level]. Reason: [reason]")
	log_admin("[key_name(user)] gave [key_name(target)] the Discipline [new_discipline.name] at rank [chosen_level]. Reason: [reason]")

	to_chat(user, span_notice("Granted [new_discipline.name] (Level [chosen_level]) to [target]."))
	to_chat(target, span_notice("You have been granted the Discipline: [new_discipline.name] (Level [chosen_level])"))

	BLACKBOX_LOG_ADMIN_VERB("Grant Discipline")
