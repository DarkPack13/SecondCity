// Presently a dummy placeholder, might want to do stuff like flavor the ui, change the dice roll, make fomori_powers private by default or the like
/datum/storyteller_roll/fomori_power

/datum/action/cooldown/power/fomori_power
	background_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	background_icon_state = "bg_fomori_power"
	button_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	//button_icon_state = ""
	overlay_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'

	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS

/atom/movable/screen/alert/status_effect/fomori_power
	icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	icon_state = "bg_fomori_power"
	overlay_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
