/datum/bodypart_overlay/simple/fomor_exoskeleton
	icon_state = "exoskeleton"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = BENEATH_HAIR_LAYER

/datum/action/cooldown/power/fomori_power/exoskeleton
	name = "Exoskeleton"
	desc = "(NEED SPRITES) Form a thick carapace around your body, protecting you from harm and increasing your strength."
	button_icon_state = "exoskeleton"
	rank = 1 // of 1

	fomor_part = /datum/bodypart_overlay/simple/fomor_exoskeleton

/datum/action/cooldown/power/fomori_power/exoskeleton/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/carbon_owner = astype(owner, /mob/living/carbon)

	toggle_feature(deployed)

	if(deployed)
		deployed = FALSE
		carbon_owner.st_remove_stat_mod(STAT_STAMINA, 1, "exoskeleton")
		carbon_owner.st_remove_stat_mod(STAT_STRENGTH, 1, "exoskeleton")
		playsound(owner, 'modular_darkpack/modules/powers/sounds/potence_deactivate.ogg', 50)
	else
		deployed = TRUE
		carbon_owner.st_add_stat_mod(STAT_STAMINA, 1, "exoskeleton")
		carbon_owner.st_add_stat_mod(STAT_STRENGTH, 1, "exoskeleton")
		playsound(owner, 'modular_darkpack/modules/powers/sounds/potence_activate.ogg', 50)
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
