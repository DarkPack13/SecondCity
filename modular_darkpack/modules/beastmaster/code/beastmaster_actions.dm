//action buttons
/datum/action/beastmaster_command_stay
	name = "Command: Stay"
	desc = "Order all minions to stay in place."
	button_icon = 'icons/hud/radial_pets.dmi'
	button_icon_state = "halt"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/beastmaster_command_stay/Trigger(trigger_flags)
	. = ..()
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	for(var/mob/living/minion in H.beastmaster_minions)
		if(QDELETED(minion))
			continue
		var/datum/component/obeys_commands/obeys = H.minion_command_components[minion]
		if(!obeys)
			continue
		var/datum/pet_command/idle/stay_cmd = obeys.available_commands["Stay"]
		if(stay_cmd)
			stay_cmd.try_activate_command(H, radial_command = FALSE)

/datum/action/beastmaster_command_follow
	name = "Command: Follow"
	desc = "Order all minions to follow you."
	button_icon = 'icons/hud/radial_pets.dmi'
	button_icon_state = "follow"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/beastmaster_command_follow/Trigger(trigger_flags)
	. = ..()
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	for(var/mob/living/minion in H.beastmaster_minions)
		if(QDELETED(minion))
			continue

		//teleport if on different z-level
		if(minion.z != owner.z && get_dist(minion, owner) < 12)
			minion.forceMove(owner.loc)

		var/datum/component/obeys_commands/obeys = H.minion_command_components[minion]
		if(!obeys)
			continue
		var/datum/pet_command/follow/follow_cmd = obeys.available_commands["Follow"]
		if(follow_cmd)
			follow_cmd.try_activate_command(H, radial_command = FALSE)

/datum/action/beastmaster_command_end_aggression
	name = "Command: End Aggression"
	desc = "Order all minions to stop attacking."
	button_icon = 'icons/hud/radial_pets.dmi'
	button_icon_state = "free"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/beastmaster_command_end_aggression/Trigger(trigger_flags)
	. = ..()
	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	for(var/mob/living/minion in H.beastmaster_minions)
		if(QDELETED(minion))
			continue
		var/datum/component/obeys_commands/obeys = H.minion_command_components[minion]
		if(!obeys)
			continue
		var/datum/pet_command/free/end_aggression_cmd = obeys.available_commands["Loose"]
		if(end_aggression_cmd)
			end_aggression_cmd.try_activate_command(H, radial_command = FALSE)

