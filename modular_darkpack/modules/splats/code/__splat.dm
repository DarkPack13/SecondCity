/**
 * # Splat
 *
 * A type of supernatural being (like vampires, werewolves, ghouls, etc.) that
 * players can be. Has traits and actions that are inherent to all members
 * of the splat, storyteller traits that are available to them, and resources
 * that can be used to power their abilities.
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
	/// Storyteller traits members of this splat can take
	var/list/splat_st_traits
	/// Actions inherent to this splat
	var/list/splat_actions

	/// Dictionary of resources to current values
	var/list/resources
	/// Dictionary of resources to maximum values
	var/list/max_resources

	/// Currently unused, supposed to be what type of power this splat uses (like Disciplines)
	var/power_type
	/// Splats that cannot co-exist with this splat
	var/list/incompatible_splats

	/// Supernatural powers of this splat possessed by the owner
	var/list/datum/discipline/powers
	/// Mob this splat belongs to
	var/mob/living/owner

/* GAINING SPLATS */
/datum/splat/proc/assign(mob/living/owner)
	src.owner = owner

	owner.splats += src

	on_gain()

/datum/splat/proc/on_gain()
	SHOULD_CALL_PARENT(TRUE)

	SEND_SIGNAL(owner, COMSIG_LIVING_GAIN_SPLAT, src)

	add_traits()

	add_actions()

/datum/splat/proc/add_traits()
	for (var/trait in splat_traits)
		ADD_TRAIT(owner, trait, id)

/datum/splat/proc/add_actions()
	for (var/adding_action in splat_actions)
		var/datum/action/new_action = new adding_action
		new_action.Grant(owner)

/* LOSING SPLATS */
/datum/splat/proc/unassign(annihilate = TRUE)
	on_lose()

	owner.splats -= src

	// This clears out every single instantiated datum on this splat, very dangerous
	if (annihilate)
		QDEL_LIST(powers)

	qdel(src)

/datum/splat/proc/on_lose()
	SHOULD_CALL_PARENT(TRUE)

	SEND_SIGNAL(owner, COMSIG_LIVING_LOSE_SPLAT, src)

	remove_traits()

	remove_actions()

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
// standardise this all when the power system is made universal
/datum/splat/proc/create_powers(list/power_types, list/levels)
	return

/datum/splat/proc/add_power(power_type, level)
	return

/datum/splat/proc/remove_power(power_type)
	return

/* RESOURCE MANAGEMENT */
/datum/splat/proc/get_resource(resource)
	return resources[resource]

/datum/splat/proc/add_resource(resource, amount = 1)
	if (!resource || (amount <= 0))
		return FALSE

	if (!(resource in resources) || !(resource in max_resources))
		return FALSE

	if (resources[resource] == max_resources[resource])
		return FALSE

	resources[resource] = min(resources[resource] + amount, max_resources[resource])

	return TRUE

/datum/splat/proc/remove_resource(resource, amount = 1)
	if (!resource || (amount <= 0))
		return FALSE

	if (!(resource in resources) || !(resource in max_resources))
		return FALSE

	if ((resources[resource] - amount) < 0)
		return FALSE

	resources[resource] -= amount

	return TRUE

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

/mob/proc/is_splat_incompatible(splat_type)
	return

/mob/living/is_splat_incompatible(splat_type)
	for (var/datum/splat/splat in splats)
		if (splat_type in splat.incompatible_splats)
			return TRUE
		if (splat.type == splat_type)
			return TRUE

	return FALSE
