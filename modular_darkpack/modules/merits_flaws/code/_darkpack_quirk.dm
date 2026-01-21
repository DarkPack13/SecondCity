/datum/quirk/darkpack
	abstract_parent_type = /datum/quirk/darkpack
	/// List of splats (vampire clans/types) this quirk is allowed for. Null = all allowed
	var/list/allowed_splats
	/// List of splats this quirk is explicitly forbidden for
	var/list/forbidden_splats
	/// Excluded clans from this quirk (exclusive to vampire)
	var/list/excluded_clans

/datum/quirk/darkpack/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE, client/client_source, unique = TRUE, announce = TRUE)
	if(forbidden_splats)
		for(var/datum/splat/splat as anything in new_holder.splats)
			if(splat.id in forbidden_splats)
				return FALSE

	if(allowed_splats)
		var/has_allowed_splat = FALSE
		for(var/datum/splat/splat as anything in new_holder.splats)
			if(splat.id in allowed_splats)
				has_allowed_splat = TRUE
				break
		if(!has_allowed_splat)
			return FALSE

	if(excluded_clans && iskindred(new_holder))
		var/datum/splat/vampire/kindred/kindred_splat = iskindred(new_holder)
		if(kindred_splat.clan && (kindred_splat.clan.id in excluded_clans))
			return FALSE

	return ..()
