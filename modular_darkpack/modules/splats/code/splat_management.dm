/**
 * Returns the instance of the given splat type possessed by the mob, or null
 * if not found.
 */
/mob/proc/get_splat(splat_type)
	RETURN_TYPE(/datum/splat)

	return

/mob/living/get_splat(splat_type)
	RETURN_TYPE(/datum/splat)

	return locate(splat_type) in splats

/**
 * Creates a new splat of the given type with the given arguments and assigns it
 * to the mob.
 */
/mob/living/proc/add_splat(splat_type, ...)
	RETURN_TYPE(/datum/splat)

	var/datum/splat/adding_splat
	if (length(args) > 1)
		adding_splat = new splat_type(arglist(args.Copy(2)))
	else
		adding_splat = new splat_type()

	return adding_splat.assign(src)

/**
 * Deletes the splat of the given type possessed by the mob. Returns TRUE if
 * found and deleted, or false if not.
 */
/mob/living/proc/remove_splat(splat_type)
	var/datum/splat/removing_splat = get_splat(splat_type)
	if (removing_splat)
		qdel(removing_splat)
		return TRUE

	return FALSE

/**
 * Returns if the given splat type can be added to the mob or not.
 * Incompatibilities are due to an existing splat clashing with it or the given
 * splat type already being present.
 */
/mob/living/proc/is_splat_compatible(splat_type)
	for (var/datum/splat/splat as anything in splats)
		if (splat_type in splat.incompatible_splats)
			return FALSE
		if (splat.type == splat_type)
			return FALSE

	return TRUE
