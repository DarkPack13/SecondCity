/datum/action/cooldown/power/fomori_power/horns
	name = "Horns"
	desc = "(UNIMPLEMENTED) Use the grotesque horns atop your head to gore your enemies."
	button_icon_state = "horns"
	rank = 1 // of 1

	var/deployed = FALSE

/datum/action/cooldown/power/fomori_power/horns/Grant()
	. = ..()

/datum/action/cooldown/power/fomori_power/horns/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/carbon_owner = astype(owner, /mob/living/carbon)

	if(deployed)
		deployed = FALSE
		carbon_owner.remove_overlay(MUTATIONS_LAYER)
	else
		deployed = TRUE
		carbon_owner.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/fomor_overlay = mutable_appearance('modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi', "horns", -MUTATIONS_LAYER)
		carbon_owner.overlays_standing[MUTATIONS_LAYER] = fomor_overlay
		carbon_owner.apply_overlay(MUTATIONS_LAYER)
