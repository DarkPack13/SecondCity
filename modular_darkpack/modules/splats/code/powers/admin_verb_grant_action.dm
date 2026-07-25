ADMIN_VERB(give_action, R_FUN, "Give Action", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN, mob/action_recipient)
	var/which = tgui_alert(user, "Chose by name or by type path?", "Chose option", list("Name", "Typepath"))
	if(!which)
		return
	if(QDELETED(action_recipient))
		to_chat(user, span_warning("The intended action recipient no longer exists."))
		return

	var/static/list/action_list
	if(!action_list)
		action_list = list()
		var/blacklist = valid_subtypesof(/datum/action/cooldown/power) + valid_subtypesof(/datum/action/cooldown/spell) + valid_subtypesof(/datum/action/cooldown/mob_cooldown)
		for(var/datum/action/to_add as anything in valid_subtypesof(/datum/action) - blacklist)
			var/action_name = to_add::name
			if(which == "Name")
				action_list[action_name] = to_add
			else
				action_list += to_add

	var/chosen_action = tgui_input_list(user, "Choose the action to give to [action_recipient]. Many actions wont function without further varediting.", "ABRAKADABRA", sort_list(action_list))
	if(isnull(chosen_action))
		return
	var/datum/action/action_path = which == "Typepath" ? chosen_action : action_list[chosen_action]
	if(!ispath(action_path))
		return

	if(QDELETED(action_recipient))
		to_chat(user, span_warning("The intended action recipient no longer exists."))
		return

	BLACKBOX_LOG_ADMIN_VERB("Give Action")
	log_admin("[key_name(user)] gave [key_name(action_recipient)] the action [chosen_action].")
	message_admins("[key_name_admin(user)] gave [key_name_admin(action_recipient)] the action [chosen_action].")

	var/datum/action/new_action = new action_path(action_recipient.mind || action_recipient)

	new_action.Grant(action_recipient)

ADMIN_VERB(remove_action, R_FUN, "Remove Action", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN, mob/removal_target)
	var/list/target_action_list = list()
	for(var/datum/action/action in removal_target.actions)
		target_action_list[action.name] = action

	if(!length(target_action_list))
		return

	var/chosen_action = tgui_input_list(user, "Choose the action to remove from [removal_target]", "ABRAKADABRA", sort_list(target_action_list))
	if(isnull(chosen_action))
		return
	var/datum/action/to_remove = target_action_list[chosen_action]
	if(!istype(to_remove))
		return

	qdel(to_remove)
	log_admin("[key_name(user)] removed the action [chosen_action] from [key_name(removal_target)].")
	message_admins("[key_name_admin(user)] removed the action [chosen_action] from [key_name_admin(removal_target)].")
	BLACKBOX_LOG_ADMIN_VERB("Remove Action")

