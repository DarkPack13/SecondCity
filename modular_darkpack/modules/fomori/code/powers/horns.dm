/datum/action/cooldown/power/fomori_power/horns
	name = "Horns"
	desc = "(UNIMPLEMENTED) Use the grotesque horns atop your head to gore your enemies."
	button_icon_state = "horns"
	rank = 1 // of 1

	var/deployed = FALSE

/datum/action/cooldown/power/fomori_power/horns/Activate(atom/target)
	. = ..()
