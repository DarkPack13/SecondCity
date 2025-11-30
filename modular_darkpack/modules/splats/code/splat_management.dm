/mob/proc/get_splat(splat_type)
	RETURN_TYPE(/datum/splat)

	return

/mob/living/get_splat(splat_type)
	RETURN_TYPE(/datum/splat)

	for (var/datum/splat/splat in splats)
		if (!istype(splat, splat_type))
			continue

		return splat

/mob/living/proc/add_splat(splat_type, ...)
	RETURN_TYPE(/datum/splat)

	var/datum/splat/adding_splat = new splat_type(arglist(args.Copy(2)))
	return adding_splat.assign(src)

/mob/living/proc/remove_splat(splat_type)
	for (var/datum/splat/found_splat in splats)
		if (!istype(found_splat, splats))
			continue

		qdel(found_splat)
		return TRUE

	return FALSE

/mob/living/proc/is_splat_incompatible(splat_type)
	for (var/datum/splat/splat in splats)
		if (splat_type in splat.incompatible_splats)
			return TRUE
		if (splat.type == splat_type)
			return TRUE

	return FALSE
