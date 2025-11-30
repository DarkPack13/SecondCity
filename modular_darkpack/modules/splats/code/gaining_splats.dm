/datum/splat/proc/on_gain()
	return

/datum/splat/proc/replace_splats()
	// Should be implemented in subclasses for unique replacement behavior
	// eg. getting Embraced transfers your Disciplines if you were a Ghoul
	return

/datum/splat/proc/assign(mob/living/owner)
	// Cannot add this splat, return null and let the calling proc handle it
	if (owner.is_splat_incompatible(type))
		return

	src.owner = owner
	owner.splats += src

	SEND_SIGNAL(owner, COMSIG_LIVING_GAIN_SPLAT, src)

	replace_splats()

	add_splat_traits()
	add_actions()

	on_gain()

	return src

/datum/splat/proc/add_splat_traits()
	for (var/trait in splat_traits)
		ADD_TRAIT(owner, trait, id)

/datum/splat/proc/add_actions()
	for (var/adding_action in splat_actions)
		var/datum/action/new_action = new adding_action
		new_action.Grant(owner)
