//register pointing signals and grant actions on the owner - this allows them to use the attack command.
/mob/living/carbon/human/proc/register_beastmaster_signals()
	if(!GetComponent(/datum/component/beastmaster_defender))
		AddComponent(/datum/component/beastmaster_defender)

	if(!locate(/datum/action/beastmaster_command_toggle_follow) in actions)
		var/datum/action/beastmaster_command_toggle_follow/toggle_follow = new()
		toggle_follow.Grant(src)
		var/datum/action/beastmaster_command_end_aggression/endaggro = new()
		endaggro.Grant(src)

/mob/living/carbon/human/proc/unregister_beastmaster_signals()
	var/datum/component/beastmaster_defender/component = GetComponent(/datum/component/beastmaster_defender)
	if(component)
		qdel(component)

	//remove action buttons
	for(var/datum/action/beastmaster_cmd in actions)
		if(istype(beastmaster_cmd, /datum/action/beastmaster_command_toggle_follow) || \
			istype(beastmaster_cmd, /datum/action/beastmaster_command_end_aggression))
			beastmaster_cmd.Remove(src)

/datum/component/beastmaster_defender/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_MOVABLE_POINTED, PROC_REF(on_beastmaster_point))

/datum/component/beastmaster_defender/Destroy()
	UnregisterSignal(parent, COMSIG_MOVABLE_POINTED)
	return ..()

/datum/component/beastmaster_defender/proc/on_beastmaster_point(datum/source, atom/pointed_at, obj/effect/temp_visual/point/point)
	SIGNAL_HANDLER

	if(!isliving(pointed_at))
		return

	var/mob/living/carbon/human/H = parent

	for(var/mob/living/minion in H.beastmaster_minions)
		if(QDELETED(minion) || !minion.ai_controller)
			continue

		var/datum/component/obeys_commands/obeys = H.minion_command_components[minion]
		if(!obeys)
			continue

		var/datum/pet_command/attack/attack_command = obeys.available_commands["Attack"]
		if(!attack_command)
			continue

		attack_command.try_activate_command(H, pointed_at, radial_command = FALSE)
