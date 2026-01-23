/datum/action/cooldown/mob_cooldown/give_vitae
	name = "Give Vitae"
	desc = "Give your vitae to someone, make the Blood Bond."
	button_icon_state = "vitae"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	button_icon = 'modular_darkpack/modules/vampire_the_masquerade/icons/vitae.dmi'
	button_icon_state = "vitae"
	background_icon = 'modular_darkpack/master_files/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_discipline"
	ranged_mousepointer = 'icons/effects/mouse_pointers/discipline.dmi'
	cooldown_time = 10 SECONDS
	vampiric = TRUE

	// How long do we take giving blood?
	var/charge_duration = 10 SECONDS

/datum/action/cooldown/mob_cooldown/give_vitae/Activate(atom/target_atom)
	if(!IN_GIVEN_RANGE(owner, target_atom, 1))
		owner.balloon_alert(owner, "too far!")
		return FALSE
	if(!target_atom.reagents)
		return FALSE
	if(target_atom == owner)
		return FALSE

	StartCooldown()
	unset_click_ability(owner, refund_cooldown = FALSE)
	owner.visible_message(span_danger("[owner] starts pouring blood into \the [target_atom][ismob(target_atom) ? "'s mouth" : null]!"), span_info("You start pouring blood into \the [target_atom][ismob(target_atom) ? "'s mouth" : null]."))
	if(!do_after(owner, delay = charge_duration, target = target_atom))
		return FALSE

	var/mob/living/carbon/carbon_owner = owner
	if(carbon_owner.bloodpool < 1)
		to_chat(carbon_owner, span_danger("You don't have enough vitae!"))
		return FALSE

	owner.visible_message(span_danger("[owner] finishes pouring blood into \the [target_atom][ismob(target_atom) ? "'s mouth" : null]!"), span_info("You finish pouring blood into \the [target_atom][ismob(target_atom) ? "'s mouth" : null]."))
	owner.log_message("poured their vitae into [key_name(target_atom)].", LOG_GAME)
	message_admins("[ADMIN_LOOKUPFLW(carbon_owner)] poured their vitae into [ADMIN_LOOKUPFLW(target_atom)].")
	carbon_owner.adjust_blood_pool(-1)
	target_atom.reagents.add_reagent(/datum/reagent/blood/vitae, 100)
	target_atom.reagents.expose(target_atom, INGEST, 1, FALSE)
	return TRUE
