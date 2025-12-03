/datum/splat/proc/on_lose()
	return

/datum/splat/proc/unassign()
	if (!owner)
		return

	SEND_SIGNAL(owner, COMSIG_LIVING_LOSE_SPLAT, src)

	on_lose()

	UnregisterSignal(owner, COMSIG_QDELETING)

	remove_splat_traits()
	remove_actions()
	clear_powers()
	remove_biotypes()

	LAZYREMOVE(owner.splats, src)
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

/datum/splat/proc/remove_biotypes()
	// Make sure we don't remove biotypes they should have without the splat
	var/skip_biotypes = NONE
	for (var/datum/splat/splat in (owner.splats - src))
		skip_biotypes |= splat.splat_biotypes
	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		skip_biotypes |= human_owner.dna?.species?.inherent_biotypes

	// Remove the biotypes
	for (var/biotype in splat_biotypes)
		if (skip_biotypes & biotype)
			continue

		owner.mob_biotypes &= ~biotype

/datum/splat/proc/handle_parent_destroyed(mob/living/source)
	SIGNAL_HANDLER

	qdel(src)
