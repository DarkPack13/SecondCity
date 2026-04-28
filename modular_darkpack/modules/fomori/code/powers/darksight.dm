/datum/action/cooldown/power/fomori_power/darksight // TODO: Make this work with more light sources
	name = "Darksight"
	desc = "See in the dark unbidden, but beware bright lights."
	button_icon_state = "darksight"
	rank = 1 // of 1

	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 1 SECONDS // So we don't click too fast

	var/activated = FALSE

/datum/action/cooldown/power/fomori_power/darksight/Activate(atom/target)
	. = ..()
	to_chat(owner, span_notice("You [activated ? "activate" : "deactivate"] Darksight."))
	if(activated)
		activated = FALSE
		REMOVE_TRAIT(owner, TRAIT_TRUE_NIGHT_VISION, "fomor_darksight")
		owner.remove_client_colour("fomor_darksight")
		UnregisterSignal(owner, COMSIG_MOB_FLASHED, PROC_REF(on_flashed))
	else
		activated = TRUE
		ADD_TRAIT(owner, TRAIT_TRUE_NIGHT_VISION, "fomor_darksight")
		owner.add_client_colour(/datum/client_colour/monochrome, "fomor_darksight")
		RegisterSignal(owner, COMSIG_MOB_FLASHED)
	owner.update_sight()

/datum/action/cooldown/power/fomori_power/darksight/proc/on_flashed()
	SIGNAL_HANDLER

	var/mob/living/carbon/carbon_owner = owner
	var/our_perception = carbon_owner.st_get_stat(STAT_PERCEPTION)
	carbon_owner.Stun(our_perception TURNS) // Stunned 1 TURNS per dot in perception
	if(our_perception > 1)
		to_chat(owner, span_userdanger("Your enhanced vision causes you to be stunned for an extra [our_perception] turns!"))
