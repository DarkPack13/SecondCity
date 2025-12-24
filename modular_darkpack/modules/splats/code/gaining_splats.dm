/datum/splat/proc/on_gain()
	return

/datum/splat/proc/assign(mob/living/owner)
	SHOULD_NOT_OVERRIDE(TRUE)

	// Cannot add this splat, return null and let the calling proc handle it
	if (owner.is_splat_incompatible(type))
		return

	src.owner = owner
	LAZYADD(owner.splats, src)

	SEND_SIGNAL(owner, COMSIG_LIVING_GAIN_SPLAT, src)

	add_splat_traits()
	add_actions()
	add_biotypes()

	on_gain()

	return src

/datum/splat/proc/add_splat_traits()
	PRIVATE_PROC(TRUE)

	LAZYINITLIST(splat_traits)
	owner.add_traits(splat_traits, id)

/datum/splat/proc/add_actions()
	PRIVATE_PROC(TRUE)

	for (var/adding_action in splat_actions)
		var/datum/action/new_action = new adding_action
		new_action.Grant(owner)

/datum/splat/proc/add_biotypes()
	PRIVATE_PROC(TRUE)

	for (var/adding_biotype in splat_biotypes)
		owner.mob_biotypes |= adding_biotype
