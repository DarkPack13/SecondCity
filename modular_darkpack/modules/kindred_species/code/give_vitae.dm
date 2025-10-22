/datum/action/cooldown/mob_cooldown/give_vitae
	name = "Give Vitae"
	desc = "Give your vitae to someone, make the Blood Bond."
	button_icon_state = "vitae"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	button_icon = 'modular_darkpack/modules/kindred_species/icons/vitae.dmi'
	button_icon_state = "vitae"
	background_icon = 'modular_darkpack/master_files/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_discipline"
	unset_after_click = TRUE
	vampiric = TRUE
	ranged_mousepointer = 'icons/effects/mouse_pointers/discipline.dmi'
	cooldown_time = 10 SECONDS
	// How long do we take giving blood?
	var/charge_duration = 10 SECONDS

/datum/action/cooldown/mob_cooldown/give_vitae/Activate(atom/target_atom)
	StartCooldown()
	if(!do_after(owner, delay = charge_duration, target = target_atom))
		return TRUE

	var/mob/living/carbon/carbon_owner = owner
	if(carbon_owner.bloodpool < 1)
		to_chat(carbon_owner, span_danger("You don't have enough vitae!"))
		return

	message_admins("[ADMIN_LOOKUPFLW(carbon_owner)] poured their vitae into [ADMIN_LOOKUPFLW(target_atom)].")
	carbon_owner.bloodpool = max(carbon_owner.bloodpool - 1, 0)
	carbon_owner.transfer_blood_to(target_atom, 100, TRUE, TRUE)
