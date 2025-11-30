/**
 * # Splat
 *
 * A type of supernatural being (like vampires, werewolves, ghouls, etc.) that
 * players can be. Has traits and actions that are inherent to all members
 * of the splat.
 *
 * Also manages the supernatural powers of this splat that the owner has, but
 * it's limited until future reworks improve powers.
 */
/datum/splat
	abstract_type = /datum/splat

	/// Name of the splat
	var/name
	/// Description of what the splat is and what it does
	var/desc
	/// ID for trait sources and whatnot
	var/id

	/// Traits inherent to this splat
	var/list/splat_traits
	/// Actions inherent to this splat
	var/list/splat_actions
	/// Currently unused, will be implemented when powers are refactored
	var/power_type

	/// Splats that this splat replaces when gained
	var/list/replaces_splats
	/// Splats that someone with this splat cannot gain
	var/list/incompatible_splats

	/// Powers unique to this splat possessed by the owner
	var/list/datum/action/powers
	/// Mob this splat belongs to
	var/mob/living/owner

/* GAINING SPLATS */
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

	add_traits()
	add_actions()

	on_gain()

	return src

/datum/splat/proc/add_traits()
	for (var/trait in splat_traits)
		ADD_TRAIT(owner, trait, id)

/datum/splat/proc/add_actions()
	for (var/adding_action in splat_actions)
		var/datum/action/new_action = new adding_action
		new_action.Grant(owner)

/* LOSING SPLATS */
/datum/splat/proc/on_lose()
	return

/datum/splat/unassign()
	if (!owner)
		return

	SEND_SIGNAL(owner, COMSIG_LIVING_LOSE_SPLAT, src)

	on_lose()

	remove_traits()
	remove_actions()
	clear_powers()

	owner.splats -= src
	owner = null

/datum/splat/Destroy()
	unassign()

	. = ..()

/datum/splat/proc/remove_traits()
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

/* POWER MANAGEMENT */
// standardize this all when the power system is made universal
/datum/splat/proc/get_power(power_type)
	return

/datum/splat/proc/add_power(power_type, level)
	return

/datum/splat/proc/remove_power(power_type)
	return

/datum/splat/proc/clear_powers()
	for (var/datum/action/power in powers)
		qdel(power)

/* DIRECT SPLAT INTERACTION */
/mob/proc/get_splat(splat_type)
	RETURN_TYPE(/datum/splat)

	return

/mob/living/get_splat(splat_type)
	RETURN_TYPE(/datum/splat)

	for (var/datum/splat/splat in splats)
		if (!istype(splat, splat_type))
			continue

		return splat

/mob/living/add_splat(splat_type, ...)
	RETURN_TYPE(/datum/splat)

	var/datum/splat/adding_splat = new splat_type(arglist(args.Copy(2)))
	return adding_splat.assign(src)

/mob/living/remove_splat(splat_type)
	for (var/datum/splat/found_splat in splats)
		if (!istype(found_splat, splats))
			continue

		qdel(found_splat)
		return TRUE

	return FALSE

/mob/living/is_splat_incompatible(splat_type)
	for (var/datum/splat/splat in splats)
		if (splat_type in splat.incompatible_splats)
			return TRUE
		if (splat.type == splat_type)
			return TRUE

	return FALSE
