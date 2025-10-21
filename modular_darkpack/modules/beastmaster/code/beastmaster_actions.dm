// ============= ACTION DATUMS =============
/datum/action/beastmaster_stay
	name = "Stay/Follow"
	desc = "Command to stay or follow."
	button_icon_state = "wait"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/following = FALSE

/datum/action/beastmaster_stay/Trigger(mob/living/source, trigger_flags)
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	if(!following)
		following = TRUE
		to_chat(owner, "You call your support.")
		for(var/datum/component/beastmaster_minion/component in H.beastmaster_minion_components)
			component.follow = TRUE
	else
		following = FALSE
		to_chat(owner, "Your support will wait here.")
		for(var/datum/component/beastmaster_minion/component in H.beastmaster_minion_components)
			component.follow = FALSE

/datum/action/beastmaster_deaggro
	name = "End Aggression"
	desc = "Command to stop any aggressive moves."
	button_icon_state = "deaggro"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/beastmaster_deaggro/Trigger(mob/living/source, trigger_flags)
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	for(var/datum/component/beastmaster_minion/component in H.beastmaster_minion_components)
		component.enemies = list()
		component.target = null
		to_chat(owner, "You command your minions to cease their attacks.")

/datum/action/beastmaster_combat
	name = "Engage Combat"
	desc = "Command your minions to switch into combat mode, if they can."
	button_icon_state = "combat"

/datum/action/beastmaster_combat/Trigger(mob/living/source, trigger_flags)
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	for(var/mob/living/minion in H.beastmaster_minions)
		if("combat_mode" in minion.vars)
			minion.combat_mode = !minion.combat_mode
			to_chat(owner, "You change your minion's combat stance.")
