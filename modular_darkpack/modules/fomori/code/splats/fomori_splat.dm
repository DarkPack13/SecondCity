/datum/splat/fomori
	name = "Fomori"
	desc = "An unfortunate vessel possesed by an evil spirit known as a Bane."
	id = SPLAT_FOMORI

	splat_priority = SPLAT_PRIO_FOMORI

	power_type = /datum/action/cooldown/power/fomori_power

/mob/living/carbon/human/splat/fomori
	auto_splats = list(/datum/splat/fomori)

/datum/splat/fomori/on_gain()
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/body_barbs, 1)

/datum/splat/fomori/get_power(power_type)
	RETURN_TYPE(/datum/action/cooldown/power/fomori_power)

	for(var/datum/action/cooldown/power/fomori_power/found_action as anything in powers)
		if(!istype(found_action, power_type))
			continue

		return found_action

/datum/splat/fomori/add_power(power_type, level)
	// Prevent duplicates
	if(get_power(power_type))
		return FALSE
	var/datum/action/cooldown/power/fomori_power/adding_action = new power_type()
	adding_action.Grant(owner)
	LAZYADD(powers, adding_action)
	return TRUE

/datum/splat/fomori/remove_power(power_type)
	var/datum/action/cooldown/power/fomori_power/found_action = get_power(power_type)
	if(!found_action)
		return FALSE

	LAZYREMOVE(powers, found_action)
	qdel(found_action)
	return TRUE
