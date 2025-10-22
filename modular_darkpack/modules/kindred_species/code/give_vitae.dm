/datum/action/cooldown/mob_cooldown/give_vitae
	name = "Give Vitae"
	desc = "Give your vitae to someone, make the Blood Bond."
	button_icon_state = "vitae"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	// How long do we take giving blood?
	var/charge_duration = 10 SECONDS

/datum/action/cooldown/mob_cooldown/give_vitae/Activate(atom/target_atom)
	StartCooldown()
	var/completed = do_after(owner, delay = charge_duration, target = target_atom)
	if (!completed)
		return TRUE

	var/mob/living/living_owner = owner
	living_owner.blood_volume -= 5
