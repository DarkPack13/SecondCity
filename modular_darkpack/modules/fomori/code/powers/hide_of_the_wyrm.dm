/datum/bodypart_overlay/simple/hide_of_the_wyrm
	icon_state = "hide_of_the_wyrm"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = EXTERNAL_FRONT

/datum/action/cooldown/power/fomori_power/hide_of_the_wyrm
	name = "Hide of the Wyrm"
	desc = "Form a hard, leathery hide around your body, protecting you from harm."
	button_icon_state = "hide_of_the_wyrm"
	rank = 1 // of 5

	fomor_part = /datum/bodypart_overlay/simple/hide_of_the_wyrm
	feature_bodypart = BODY_ZONE_CHEST

	var/datum/status_effect/status_effect_type

/datum/action/cooldown/power/fomori_power/hide_of_the_wyrm/Grant(mob/granted_to)
	. = ..()
	switch(rank)
		if(1)
			status_effect_type = /datum/status_effect/fortitude/one
		if(2)
			status_effect_type = /datum/status_effect/fortitude/two
		if(3)
			status_effect_type = /datum/status_effect/fortitude/three
		if(4)
			status_effect_type = /datum/status_effect/fortitude/four
		if(5)
			status_effect_type = /datum/status_effect/fortitude/one

/datum/action/cooldown/power/fomori_power/hide_of_the_wyrm/Activate(atom/target) // TODO: replace fortitude with soak dice if/when we get it
	. = ..()
	var/mob/living/carbon/carbon_owner = astype(owner, /mob/living/carbon)

	toggle_feature(deployed)

	if(deployed)
		deployed = FALSE
		owner.visible_message(span_warning("[owner]'s skin is no longer hard and leathery."), \
			span_warning("Your skin is no longer hard and leathery."))
		carbon_owner.remove_status_effect(status_effect_type)
		playsound(owner, 'modular_darkpack/modules/powers/sounds/potence_deactivate.ogg', 50)
	else
		deployed = TRUE
		owner.visible_message(span_warning("[owner]'s skin becomes hard and leathery!"), \
			span_warning("Your skin becomes hard and leathery."))
		carbon_owner.apply_status_effect(status_effect_type) // ! if we ever plan on allowing vampiric fomor, give this it's own status effect !
		playsound(owner, 'modular_darkpack/modules/powers/sounds/potence_activate.ogg', 50)
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
