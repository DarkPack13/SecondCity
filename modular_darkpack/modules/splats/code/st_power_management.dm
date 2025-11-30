/**
 * Standardize this all when the power system is made universal, the weird
 * snowflake code is a result of different powers being completely unrelated datums.
 * SOON, IT CAN BE PERFECT.
 */

/datum/splat/proc/get_power(power_type)
	return

/datum/splat/proc/add_power(power_type, level)
	return

/datum/splat/proc/remove_power(power_type)
	return

/datum/splat/proc/change_power_level(power_type, new_level)
	return

/datum/splat/proc/clear_powers()
	for (var/datum/action/power as anything in powers)
		qdel(power)

/mob/living/carbon/human/proc/give_st_powers(list/power_types, list/levels)
	for (var/index in 1 to length(power_types))
		var/power_type = power_types[index]

		var/datum/splat/found_splat = get_splat_with_power_type(power_type)
		if (!found_splat)
			continue

		// Default to level 1 if none is supplied
		var/level = length(levels) >= index ? levels[index] : 1

		give_st_power(power_type, level)

/mob/living/carbon/human/proc/give_st_power(power_type, level)
	var/datum/splat/found_splat = get_splat_with_power_type(power_type)
	if (!found_splat)
		return FALSE

	return found_splat.add_power(power_type, level)

/mob/living/carbon/human/proc/remove_st_power(power_type)
	var/datum/splat/found_splat = get_splat_with_power_type(power_type)
	if (!found_splat)
		return FALSE

	return found_splat.remove_power(power_type)

/mob/living/carbon/human/proc/change_st_power_level(power_type, new_level)
	var/datum/splat/found_splat = get_splat_with_power_type(power_type)
	if (!found_splat)
		return FALSE

	return found_splat.change_power_level(power_type, new_level)

/mob/living/proc/get_splat_with_power_type(power_type)
	RETURN_TYPE(/datum/splat)

	for (var/datum/splat/checking_splat as anything in splats)
		if (!ispath(power_type, checking_splat.power_type))
			continue

		return checking_splat
