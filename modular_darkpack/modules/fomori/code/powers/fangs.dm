/datum/action/cooldown/power/fomori_power/fangs
	name = "Fangs"
	desc = "(UNIMPLEMENTED) Use the grotesque fangs spilling from your mouth to bite your enemies."
	button_icon_state = "fangs"
	rank = 1 // of 1

	var/deployed = FALSE

/datum/action/cooldown/power/fomori_power/fangs/Activate(atom/target)
	. = ..()
