/datum/splat/proc/on_lose()
	return

/datum/splat/proc/unassign()
	if (!owner)
		return

	SEND_SIGNAL(owner, COMSIG_LIVING_LOSE_SPLAT, src)

	on_lose()

	remove_splat_traits()
	remove_actions()
	clear_powers()

	owner.splats -= src
	owner = null

/datum/splat/Destroy()
	unassign()

	. = ..()

/datum/splat/proc/remove_splat_traits()
	for (var/trait in splat_traits)
		REMOVE_TRAIT(owner, trait, id)

/datum/splat/proc/remove_actions()
	// to make sure we don't remove another splat's actions
	var/list/other_splat_actions = list()
	for (var/datum/splat/splat in (owner.splats - src))
		other_splat_actions |= splat.splat_actions

	// actually remove the actions
	for (var/removing_action in splat_actions)
		if (removing_action in other_splat_actions)
			continue

		for (var/datum/action/action in owner.actions)
			if (!istype(action, removing_action))
				continue

			action.Remove()
