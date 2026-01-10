/datum/splat/vampire
	abstract_type = /datum/splat/vampire

	power_type = /datum/discipline

/datum/splat/vampire/proc/get_discipline_power(datum/discipline_power/discipline_power_type)
	RETURN_TYPE(/datum/discipline_power)

	return get_discipline(discipline_power_type::discipline)?.get_power(discipline_power_type)

/datum/splat/vampire/proc/get_discipline(discipline_type)
	RETURN_TYPE(/datum/discipline)

	return get_power(discipline_type)?.discipline

/datum/splat/vampire/get_power(power_type)
	RETURN_TYPE(/datum/action/discipline)

	for (var/datum/action/discipline/found_action as anything in powers)
		if (!istype(found_action.discipline, power_type))
			continue

		return found_action

/datum/splat/vampire/add_power(power_type, level)
	// Prevent duplicates
	if (get_power(power_type))
		return FALSE

	var/datum/action/discipline/adding_action = new(new power_type(level))
	adding_action.Grant(owner)
	LAZYADD(powers, adding_action)
	return TRUE

/datum/splat/vampire/remove_power(power_type)
	var/datum/action/discipline/found_action = get_power(power_type)
	if (!found_action)
		return FALSE

	LAZYREMOVE(powers, found_action)
	qdel(found_action)
	return TRUE

/datum/splat/vampire/change_power_level(power_type, new_level)
	var/datum/action/discipline/found_action = get_power(power_type)
	if (!found_action)
		return FALSE

	found_action.discipline.set_level(new_level)
	return TRUE
