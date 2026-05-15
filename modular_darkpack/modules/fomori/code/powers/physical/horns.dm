/datum/bodypart_overlay/simple/fomor_horns
	icon_state = "horns"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = LOW_FACEMASK_LAYER

/datum/action/cooldown/power/fomori_power/horns
	name = "Horns"
	desc = "(UNIMPLEMENTED) Use the grotesque horns atop your head to gore your enemies."
	button_icon_state = "horns"
	rank = 1 // of 1

	fomor_part = /datum/bodypart_overlay/simple/fomor_horns

/datum/action/cooldown/power/fomori_power/horns/Activate(atom/target)
	. = ..()
	toggle_feature(deployed)

	if(deployed)
		deployed = FALSE
	else
		deployed = TRUE
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
#warn HORNS UNFINISHED
