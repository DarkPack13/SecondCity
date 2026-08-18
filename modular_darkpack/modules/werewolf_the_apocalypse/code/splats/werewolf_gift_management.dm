/datum/splat/werewolf/get_power(power_type)
	RETURN_TYPE(/datum/action/cooldown/power/gift)

	for(var/datum/action/cooldown/power/gift/found_action as anything in powers)
		if(!istype(found_action, power_type))
			continue

		return found_action

/datum/splat/werewolf/add_power(power_type, level)
	// Prevent duplicates
	if(get_power(power_type))
		return FALSE
	var/datum/action/cooldown/power/gift/adding_action = new power_type()
	adding_action.Grant(owner)
	LAZYADD(powers, adding_action)
	return TRUE

/datum/splat/werewolf/remove_power(power_type)
	var/datum/action/cooldown/power/gift/found_action = get_power(power_type)
	if(!found_action)
		return FALSE

	LAZYREMOVE(powers, found_action)
	qdel(found_action)
	return TRUE

/datum/splat/werewolf/change_power_level(power_type, new_level)
	return // We dont really have discs in the same way, and we dont have diffrent power levels for an individual power?


