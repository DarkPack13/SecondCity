/datum/splat/vampire
	abstract_type = /datum/splat/vampire

	power_type = /datum/discipline

/datum/splat/vampire/add_power(power_type, level)
	var/datum/action/discipline/adding_action = new(new power_type(level))
	adding_action.Grant(owner)
	powers += adding_action

/datum/splat/vampire/remove_power(power_type)
	for (var/datum/action/discipline/action as anything in powers)
		if (!istype(action.discipline, power_type))
			continue

		qdel(action)
