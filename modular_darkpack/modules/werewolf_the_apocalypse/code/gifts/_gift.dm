/datum/action/cooldown/power/gift
	background_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	background_icon_state = "bg_gift"
	button_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	//button_icon_state = ""
	overlay_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'

	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS


	var/rage_req = 0
	var/gnosis_req = 0

/datum/action/cooldown/power/gift/IsAvailable(feedback)
	. = ..()

	if(!ishuman(owner))
		if(feedback)
			owner.balloon_alert(owner, "not human!")
		return FALSE

	var/datum/splat/werewolf/casting_splat = iswerewolfsplat(owner)

	if(get_rage_cost())
		if(casting_splat.rage < get_rage_cost())
			if(feedback)
				to_chat(owner, span_warning("You don't have enough <b>RAGE</b> to do that!"))
				SEND_SOUND(owner, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/werewolf_cast_failed.ogg', volume = 50))
			return FALSE
	if(gnosis_req)
		if(casting_splat.gnosis < gnosis_req)
			if(feedback)
				to_chat(owner, span_warning("You don't have enough <b>GNOSIS</b> to do that!"))
				SEND_SOUND(owner, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/werewolf_cast_failed.ogg', volume = 50))
			return FALSE


/datum/action/cooldown/power/gift/Activate(atom/target)
	. = ..()
	if(!ishuman(owner))
		return FALSE

	var/datum/splat/werewolf/casting_splat = iswerewolfsplat(owner)

	if(get_rage_cost())
		casting_splat.adjust_rage(-get_rage_cost(), owner, FALSE)
	if(get_gnosis_cost())
		casting_splat.adjust_gnosis(-get_gnosis_cost(), owner, FALSE)
	to_chat(owner, span_notice("You activate the [name]..."))

/datum/action/cooldown/power/gift/proc/get_rage_cost()
	return rage_req

/datum/action/cooldown/power/gift/proc/get_gnosis_cost()
	return gnosis_req
